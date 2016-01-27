//
//  AssessmentViewController.m
//  SimpleTable
//
//  Created by Vinod Rathod on 25/01/16.
//
//

#import "AssessmentViewController.h"
#import <TNRadioButtonGroup/TNRadioButtonGroup.h>
#import <CoreText/CoreText.h>

@interface AssessmentViewController ()

@end

@implementation AssessmentViewController {
    NSMutableDictionary *_sliderDicValues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    _sliderDicValues = [[NSMutableDictionary alloc] init];
    
    self.contentView.layer.cornerRadius = 6.f;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];
    
    [self.navigationController.navigationBar setBarTintColor:self.navBarColor];
    
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:self.backgroundImageString]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *questions = self.details[@"questions"];
    
    return questions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *radioButtonCellIdentifier = @"radioButtonCellIdentifier";
    static NSString *sliderCellIdentifier   = @"slidingAssessmentIdentifier";
    
    NSArray *options = self.details[@"options"];
    
    id cell;
    
    if (options == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:sliderCellIdentifier forIndexPath:indexPath];
        [self configureSliderCell:cell forIndexPath:indexPath];
    }
    else {
        
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:radioButtonCellIdentifier];
        
        NSArray *question_options = options[indexPath.row];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:radioButtonCellIdentifier];
        }
        [self configureRadioButtonCell:cell forIndexPath:indexPath withQuestionOptions:question_options];
        
    }
    
    
    return cell;
}


-(void)configureSliderCell:(SliderAssessmentTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *questions = self.details[@"questions"];
    
    
    cell.question.text      = questions[indexPath.row];
    cell.question.textColor = [self darkerColorForColor:self.navBarColor];
    cell.backgroundColor = [UIColor clearColor];
    
    if([_sliderDicValues objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) //check if there is any slided value is present
    {
        NSNumber *value = [_sliderDicValues objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        [cell.slider setValue:value.integerValue]; //set the slider value
        [cell.slidingValue setText:[NSString stringWithFormat:@"%ld",(long)value.integerValue]];//and also label
    }
    else //set to default values
    {
        [cell.slider setValue:(NSInteger)0];
        [cell.slidingValue setText:@"0"];
    }
    //add a single target don't add double target to slider
    cell.sliderDelegate = self;
    
}

-(void)sliderChanged:(SliderAssessmentTableViewCell *)cell {
    NSIndexPath *path = [self.tableView indexPathForCell:cell]; //get the indexpath
    if(path)//check if valid path
    {
        int value = cell.slider.value;
        [_sliderDicValues setObject:[NSNumber numberWithInt:value] forKey:[NSString stringWithFormat:@"%ld",(long)path.row]]; //set the value in the dictionary later used in the cellForRowAtIndexPath method
    }
    
}


-(void)configureRadioButtonCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath withQuestionOptions:(NSArray *)question_options {
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSArray *questions = self.details[@"questions"];
    
    CGFloat height = [self findHeightForText:questions[indexPath.row] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:15.f]].height;
    
    UILabel *question = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.tableView.frame.size.width - 8, height)];
    question.font = [UIFont fontWithName:@"AvenirNext-Medium" size:15.f];
    question.textColor = [self darkerColorForColor:self.navBarColor];
    question.numberOfLines = 0;
    question.text       = questions[indexPath.row];
    
    [cell.contentView addSubview:question];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [question_options enumerateObjectsUsingBlock:^(NSString * _Nonnull option, NSUInteger idx, BOOL * _Nonnull stop) {
        TNCircularRadioButtonData *button = [TNCircularRadioButtonData new];
        button.labelText = option;
        button.identifier = option;
        if (idx == 0) {
            button.selected = YES;
        }
        else
            button.selected = NO;
        button.borderRadius = 12;
        button.circleRadius = 5;
        
        [array addObject:button];
    }];
    
    TNRadioButtonGroup *group = [[TNRadioButtonGroup alloc] initWithRadioButtonData:array layout:TNRadioButtonGroupLayoutVertical];
    group.identifier = @"Sex group";
    [group create];
    group.position = CGPointMake(10, 8+height+8);
//    group
    [cell.contentView addSubview:group];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *questions = self.details[@"questions"];
    NSArray *options = self.details[@"options"];
    
    CGFloat height1 = [self findHeightForText:questions[indexPath.row] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:15.f]].height;
    
    if (options[indexPath.row] == nil) {
        NSString *string = questions[indexPath.row];
        
        CGFloat stringHeight = [self findHeightForText:string havingWidth:tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
        
        if (stringHeight > 20.f) {
            return 100 + stringHeight;
        }
        else
            return 100;
    }
    else {
        
        NSArray *question_options = options[indexPath.row];
        CGFloat height = height1 + (35 * question_options.count);
        
        return height;
    }
    
    return 100;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSString *string = self.details[@"header"];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                          NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                          }];
    
    return [self findHeightForText:attributedString havingWidth:tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *string = self.details[@"header"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{
                                                                                                          NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                          }];
    CGFloat height = [self findHeightForText:attributedString havingWidth:tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
    
    
    
    
    
    NSArray *array = [string componentsSeparatedByString:@"\n\n"];
    NSLog(@"%@", array);
    
    
    for (int i=0; i<2; i++) {
        NSRange range = [string rangeOfString:array[i]];
        
        if (i == 0) {
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-Bold" size:18.f] range:range];
        }
        else
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.f] range:range];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[self darkerColorForColor:self.navBarColor] range:NSMakeRange(0, string.length)];
        

    }
    

    
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    textView.attributedText      = attributedString;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:textView];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50.f;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    CGFloat width = tableView.frame.size.width;
    NSLog(@"Width %f", width);
    UIButton *resultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, footerView.frame.size.height/2 - 22.5f, width, 45.f)];
    
    NSLog(@"Button %@", NSStringFromCGRect(resultButton.frame));
    NSLog(@"ContentView %@", NSStringFromCGRect(self.contentView.frame));
    NSLog(@"View %@", NSStringFromCGRect(self.view.frame));
    resultButton.backgroundColor = [UIColor whiteColor];
    [resultButton setTitle:@"GET RESULT" forState:UIControlStateNormal];
    [resultButton setTitleColor:[self darkerColorForColor:self.navBarColor] forState:UIControlStateNormal];
    [resultButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]];
    resultButton.layer.cornerRadius = 25.f;
    resultButton.layer.masksToBounds = YES;
    
    [footerView addSubview:resultButton];
    
    return footerView;
}




- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

- (CGSize)findHeightForText:(id)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if ([text isKindOfClass:[NSAttributedString class]]) {
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        size = CGSizeMake(ceilf(frame.size.width), ceilf(frame.size.height));
    }
    else {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        size = CGSizeMake(ceilf(frame.size.width), ceilf(frame.size.height));
    }
    
    return size;
}

@end
