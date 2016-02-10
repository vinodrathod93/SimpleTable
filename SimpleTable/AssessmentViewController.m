//
//  AssessmentViewController.m
//  SimpleTable
//
//  Created by Vinod Rathod on 25/01/16.
//
//

#import "AssessmentViewController.h"
#import <CoreText/CoreText.h>

@interface AssessmentViewController ()<RadioButtonCellDelegate>

@end

@implementation AssessmentViewController {
    NSMutableDictionary *_sliderDicValues;
    NSMutableDictionary *_radioButtonDicValues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    _sliderDicValues = [[NSMutableDictionary alloc] init];
    _radioButtonDicValues = [[NSMutableDictionary alloc] init];
    
    self.contentView.layer.cornerRadius = 6.f;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];
    
    [self.navigationController.navigationBar setBarTintColor:self.navBarColor];
    
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:self.backgroundImageString]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundView.image];
//    [self.view addSubview:backgroundView];
//    [self.view sendSubviewToBack:backgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
     NSArray *options = self.details[@"options"];
    
    // if slider view
    if (options == nil) {
        return 1;
    }
    else {
        NSArray *questions = self.details[@"questions"];
        return questions.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *options = self.details[@"options"];
    
    // if slider view
    if (options == nil) {
        NSArray *questions = self.details[@"questions"];
        return questions.count;
    }
    else {
        
        
        NSArray *question_options = options[section];
        return question_options.count;
        
        
    }
    
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
        
        cell = [tableView dequeueReusableCellWithIdentifier:radioButtonCellIdentifier];
        
        NSArray *question_options = options[indexPath.section];
        if (cell == nil) {
            cell = [[RadioButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:radioButtonCellIdentifier];
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
    
    
    cell.slider.maximumValue = [self.details[@"max"] floatValue];
    
    NSLog(@"Slider Dictionary ===>    %@", _sliderDicValues);
    
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


-(void)configureRadioButtonCell:(RadioButtonCell *)cell forIndexPath:(NSIndexPath *)indexPath withQuestionOptions:(NSArray *)question_options {
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat optionHeight = [self findHeightForText:question_options[indexPath.row] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.f]].height;
    
    
    
    
    
    cell.radioButton.frame = CGRectMake(8, 0, self.tableView.frame.size.width - 8, optionHeight + (2*8));
    cell.radioButton.tag = (indexPath.section * 50) + indexPath.row;
    
    
    NSLog(@"Radio Dictionary %@", _radioButtonDicValues);
    
    
    
    if ([_radioButtonDicValues objectForKey:@(indexPath.section)]) {
        
        if (indexPath.row == [[_radioButtonDicValues objectForKey:@(indexPath.section)] integerValue]) {
            [cell selectRadioButton];
        }
        else
            [cell deselectRadioButton];
        
    }
    else {
        [cell deselectRadioButton];
    }
//    else if ( [cell.radioButton isSelected]) 
//        [cell deselectRadioButton];
    
    
    
    [cell.radioButton setTitle:question_options[indexPath.row] forState:UIControlStateNormal];
    cell.delegate = self;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *questions = self.details[@"questions"];
    NSArray *options = self.details[@"options"];
    
//    CGFloat height1 = [self findHeightForText:questions[indexPath.section] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:15.f]].height;
    
    if (options[indexPath.section] == nil) {
        NSString *string = questions[indexPath.section];
        
        CGFloat stringHeight = [self findHeightForText:string havingWidth:tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
        
        if (stringHeight > 20.f) {
            return 100 + stringHeight;
        }
        else
            return 100;
    }
    else {
        
        NSArray *question_options = options[indexPath.section];
        
        CGFloat optionHeight = [self findHeightForText:question_options[indexPath.row] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.f]].height;
        return optionHeight + (2*8);
    }
    
    return 100;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *questions = self.details[@"questions"];
    NSArray *options = self.details[@"options"];
    
    CGFloat height1 = [self findHeightForText:questions[section] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:15.f]].height;
    
    
    // Header text
    NSString *string = self.details[@"header"];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                          NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                          }];
    
    CGFloat questionHeight = [self findHeightForText:questions[section] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:15.f]].height;
    
    CGFloat textHeight = [self findHeightForText:attributedString havingWidth:tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
    
    
    
    if (options == nil) {
        if (section == 0) {
            
            return textHeight;
        }
        else
            return 1.0f;
    }
    else {
        
        if (section == 0) {
            CGFloat sectionHeight = textHeight + questionHeight + (2*8);
            
            return sectionHeight;
        }
        else
            return height1 + (2*8);
    }
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *options = self.details[@"options"];
    
    
    
    CGFloat height = [self findHeightForText:[self attributedHeaderString] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    textView.attributedText      = [self attributedHeaderString];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:textView];
    
    // if slider view
    if (options == nil) {
        
        if (section == 0) {
            
            
            return headerView;
        }
        else
            return [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    else {
        
        
        UILabel *question = [[UILabel alloc] init];
        question.font = [UIFont fontWithName:@"AvenirNext-Medium" size:15.f];
        question.numberOfLines = 0;
        
        
        
        
        NSArray *questions = self.details[@"questions"];
        
        CGFloat questionHeight = [self findHeightForText:questions[section] havingWidth:self.tableView.frame.size.width andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:15.f]].height;
        
        question.textColor = [self darkerColorForColor:self.navBarColor];
        question.text       = questions[section];
        
        
        if (section == 0) {
            
            question.frame = CGRectMake(8, 8 + height, self.tableView.frame.size.width - 8, questionHeight);
            // increase height of headerview
            
            headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, height + questionHeight + 8 + 8);
            
            [headerView addSubview:question];
            
            return headerView;
        }
        else {
            
            UIView *questionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, questionHeight + (2*8))];
            
            question.frame = CGRectMake(8, 8, self.tableView.frame.size.width - 8, questionHeight);
            [questionHeaderView addSubview:question];
            
            return questionHeaderView;
        }
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    NSArray *questions = self.details[@"questions"];
    NSArray *options = self.details[@"options"];
    
    NSInteger lastIndex = [questions indexOfObject:questions.lastObject];
    
    
    if (options == nil) {
        return 80.f;
    }
    else if (section == lastIndex) {
        return 80.f;
    }
    else
        return 1.f;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    NSArray *options = self.details[@"options"];
    NSArray *questions = self.details[@"questions"];
    NSInteger lastIndex = [questions indexOfObject:questions.lastObject];
    
    if (options == nil) {
        return [self footerButton];
    }
    else if (section == lastIndex) {
        
        return [self footerButton];
    }
    else
        return nil;
    
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


-(NSMutableAttributedString *)attributedHeaderString {
    
    NSString *string = self.details[@"header"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{
                                                                                                                        NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                                        }];
    
    
    
    
    
    
    NSArray *array = [string componentsSeparatedByString:@"\n\n"];
//    NSLog(@"%@", array);
    
    
    for (int i=0; i<2; i++) {
        NSRange range = [string rangeOfString:array[i]];
        
        if (i == 0) {
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-Bold" size:18.f] range:range];
        }
        else
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.f] range:range];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[self darkerColorForColor:self.navBarColor] range:NSMakeRange(0, string.length)];
        
        
    }
    
    
    return attributedString;
}

-(UIView *)footerButton {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 80)];
    
    CGFloat width = _tableView.frame.size.width;
    
    UIButton *resultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, footerView.frame.size.height/2 - 22.5f, width, 45.f)];
    
    resultButton.backgroundColor = [UIColor whiteColor];
    [resultButton setTitle:@"GET RESULT" forState:UIControlStateNormal];
    [resultButton setTitleColor:[self darkerColorForColor:self.navBarColor] forState:UIControlStateNormal];
    [resultButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]];
    [resultButton addTarget:self action:@selector(tappedResults) forControlEvents:UIControlEventTouchUpInside];
    resultButton.layer.cornerRadius = 25.f;
    resultButton.layer.masksToBounds = YES;
    
    [footerView addSubview:resultButton];
    
    return footerView;
}



-(void)radioButtonCellDidSelect:(RadioButtonCell *)selectedCell {
    NSIndexPath *selectedPath = [self.tableView indexPathForCell:selectedCell];
    
    
    [_radioButtonDicValues setObject:@(selectedPath.row) forKey:@(selectedPath.section)];
    
    for (int section = 0; section < [self.tableView numberOfSections]; section++) {
        NSLog(@"Radio section %d", section);
        if(section == selectedPath.section) {
            
            NSLog(@"Selected section %d", section);
            for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
                NSIndexPath *cellPath = [NSIndexPath indexPathForRow:row inSection:section];
                RadioButtonCell *cell = (RadioButtonCell*)[self.tableView cellForRowAtIndexPath:cellPath];
                
                NSLog(@"Cell is Selected");
                if(selectedPath.row != cellPath.row) {
                    [cell deselectRadioButton];
                }
            }
        }
    }
    

}



-(NSInteger)calculateSliderTotal {
    
    __block NSInteger total = 0;
    
    [_sliderDicValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    
    NSLog(@"Total is %d", total);
    
    return total;
}


-(NSInteger)calculateRadioButtonTotal {
    
    __block NSInteger total = 0;
    
    [_radioButtonDicValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    
    NSLog(@"Radio Total is %d", total);
    
    return total;
}




-(void)tappedResults {
    
    NSInteger ans = [self calculateSliderTotal];
    NSInteger ansr = [self calculateRadioButtonTotal];
    
    NSArray *results = self.details[@"results"];
    NSString *message;
    
    switch (self.index) {
        case 0:
        {
            if(ans>=0 && ans <5)
            {
                message = results[0];
            }
            else if(ans >=5 && ans <= 9)
            {
                message = results[1];
            }
            else if (ans >=10 && ans <=14)
            {
                message = results[2];
            }
            else if (ans >=15 && ans <=19)
            {
                message = results[3];
            }
            else if (ans==20)
            {
                message = results[4];
            }
            else if (ans >=21 && ans <=25)
            {
                message = results[5];
            }
            else if (ans >=26 && ans <=30)
            {
                message = results[6];
            }
            else if (ans >=31 && ans <=35)
            {
                message = results[7];
            }
        }
            break;
            
        case 1:
        {
            if(ans>=0 && ans <10){
                
                message = results[0];
            }
            else if (ans >=10 && ans <=40)
            {
                message = results[1];
            }
            else if (ans >=41 && ans <=80)
            {
                message = results[2];
            }
            else if (ans >=81 && ans <=120)
            {
                message = results[3];
            }
            else if (ans >=121 && ans <=160)
            {
                message = results[4];
            }
            else if (ans >=161 && ans <=200)
            {
                message = results[5];
            }
        }
            break;
            
        case 2:
        {
            if (ansr >=0 && ansr <= 7)
            {
                message = results[0];
            }
            else if (ansr >= 8 && ansr <= 15)
            {
                message = results[1];
            }
            else if (ansr >= 16 && ansr <= 19)
            {
                message = results[2];
            }
            else if (ansr >= 20)
            {
                message = results[3];
            }
        }
            break;
            
        case 3:
        {
            if (ansr >=0 && ansr <= 7)
            {
                message = results[0];
            }
            else if (ansr >= 8 && ansr <= 14)
            {
                message = results[1];
            }
            else if (ansr >= 15 && ansr <= 21)
            {
                message = results[2];
            }
            else if (ansr >= 22)
            {
                message = results[3];
            }
        }
            break;
            
            
        case 4:
        {
            if(ans>=0 && ans <=19){
                
                message = results[0];
            }
            else if (ans >=20 && ans <=39)
            {
                message = results[1];
            }
            else if (ans >=40 && ans <=56)
            {
                message = results[2];
            }
        }
            break;
            
        case 5:
        {
            if (ans <= 14)
            {
                message = results[0];
            }
            else if (ans >= 15 && ans <=25)
            {
                message = results[1];
            }
            else if (ans >= 26 && ans <=30)
            {
                message = results[2];
            }
        }
            break;
            
        case 6:
        {
            if (ans < 36)
            {
                message = results[0];
            }
            else if (ans >= 36)
            {
                message = results[1];
            }
        }
            break;
            
        case 7:
        {
            if (ansr >=0 && ansr <= 15)
            {
                message = results[0];
            }
            else if (ansr >=16 && ansr <=25)
            {
                message = results[1];
            }
            else if (ansr >= 25 && ansr <= 32)
            {
                message = results[2];
            }
        }
            break;
            
        case 8:
        {
            if (ans <= 10)
            {
                message = results[0];
            }
            else if (ans >=11 && ans <=19)
            {
                message = results[1];
            }
            else if (ans >=20 && ans <=35)
            {
                message = results[2];
            }
            else if (ans >=36 && ans <=50)
            {
                message = results[3];
            }
        }
            break;
            
        case 9:
        {
            if (ans <= 11)
            {
                message = results[0];
            }
            else if (ans >=12 && ans <=27)
            {
                message = results[1];
            }
            else if (ans >=28 && ans <=43)
            {
                message = results[2];
            }
            else if (ans >=44 && ans <=60)
            {
                message = results[3];
            }
        }
            break;
            
        case 10:
        {
            if (ans <= 19)
            {
                message = results[0];
            }
            else if (ans >=20 && ans <=24)
            {
                message = results[1];
            }
            else if (ans >=25 && ans <=29)
            {
                message = results[2];
            }
            else if (ans >=30 && ans <=50)
            {
                message = results[3];
            }
        }
            break;
            
        case 11:
        {
            if (ans <= 5)
            {
                message = results[0];
            }
            else if (ans >=6 && ans <=10)
            {
                message = results[1];
            }
            else if (ans >=11 && ans <=15)
            {
                message = results[2];
            }
            else if (ans >=16 && ans <=21)
            {
                message = results[3];
            }
        }
            break;
            
        case 12:
        {
            if (ans <= 11)
            {
                message = results[0];
            }
            else if (ans >=12 && ans <=22)
            {
                message = results[1];
            }
            else if (ans >=23 && ans <=35)
            {
                message = results[2];
            }
        }
            break;
            
        default:
        {
            if (ansr >=0 && ansr <= 3)
            {
                message = results[0];
            }
            else if (ansr >= 3 && ansr <= 12)
            {
                message = results[1];
            }
            else if (ansr >= 12 && ansr <= 20)
            {
                message = results[2];
            }
        }
            break;
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Results" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
}


@end
