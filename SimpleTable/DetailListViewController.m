//
//  DetailListViewController.m
//  SimpleTable
//
//  Created by Vinod Rathod on 19/01/16.
//
//

#import "DetailListViewController.h"
#import "DetailTableViewCell.h"
#import "FactsTableViewController.h"
#import <CoreText/CoreText.h>

@interface DetailListViewController ()

@end

@implementation DetailListViewController {
    NSInteger _cellSection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:self.bg_image]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.detailsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCellIdentifier" forIndexPath:indexPath];
    cell.tag = indexPath.section;
    
    UITapGestureRecognizer *textViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoFactsVC:)];
//    textViewTapRecognizer.
    
    NSString *string = self.detailsArray[indexPath.section];
    
    // Configure the cell...
    cell.backgroundColor = [UIColor clearColor];
    cell.roundedView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    cell.roundedView.layer.cornerRadius = 10.f;
    cell.textView.backgroundColor = [UIColor clearColor];
    [cell.textView addGestureRecognizer:textViewTapRecognizer];
    
    UIColor *textColor              = [UIColor colorWithRed:34/255.f green:167/255.f blue:240/255.f alpha:1.0];
    
    
    cell.textView.textColor       = [self darkerColorForColor:textColor];
    cell.textView.editable      = NO;
    
    if (self.main_index == 0) {
        NSString *keyword = self.attributedArray[indexPath.section];
        
        NSRange range = [string rangeOfString:keyword];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{
                                                                                                                            NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                                            }];
        [attributedString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:@(kCTUnderlineStyleSingle) range:range];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[self darkerColorForColor:textColor] range:NSMakeRange(0, string.length)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-DemiBold" size:15.f] range:range];
        
        cell.textView.attributedText = attributedString;

    }
    else if (self.main_index == 3) {
        cell.textView.textAlignment = NSTextAlignmentCenter;
        cell.textView.attributedText = [self attributedHeaderStringForSection:indexPath.section];
    }
    else {
        cell.textView.textAlignment = NSTextAlignmentCenter;
        cell.textView.text  = string;
    }
    
    
    
    return cell;
}




-(void)gotoFactsVC:(UITapGestureRecognizer *)sender {
    
    
    if (self.main_index == 1) {
        DetailTableViewCell *cell = (DetailTableViewCell *)[[[[sender view] superview] superview] superview];
        
        FactsTableViewController *factsDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"factsTableVC"];
        factsDetails.bg_image = self.bg_image;
        factsDetails.index = cell.tag;
        factsDetails.factDetails = [self getFactsDataArray][cell.tag];
        [self.navigationController pushViewController:factsDetails animated:YES];
    }
    

}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *string = self.detailsArray[indexPath.section];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                          NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                          }];
    
    NSInteger height = [self findHeightForText:attributedString havingWidth:self.view.frame.size.width-52 andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
    
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10.f;
    }
    else
        return 5.f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    
    if (section == 0) {
        header.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
    }
    else
        header.frame = CGRectMake(0, 0, self.view.frame.size.width, 5);
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    
    footer.frame = CGRectMake(0, 0, self.view.frame.size.width, 5);
    
    return footer;
}


- (CGSize)findHeightForText:(NSAttributedString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        size = CGSizeMake(ceilf(frame.size.width), ceilf(frame.size.height) + 33.5f);
    }
    return size;
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


-(NSMutableAttributedString *)attributedHeaderStringForSection:(NSInteger)section {
    
    NSString *string = self.detailsArray[section];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{
                                                                                                                        NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                                        }];
    
    
    
    
    UIColor *textColor              = [UIColor colorWithRed:34/255.f green:167/255.f blue:240/255.f alpha:1.0];
    
    NSArray *array = [string componentsSeparatedByString:@"\n\n"];
    //    NSLog(@"%@", array);
    
    
    for (int i=0; i<3; i++) {
        NSRange range = [string rangeOfString:array[i]];
        
        if (i == 0 || i ==2) {
            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-Bold" size:15.f] range:range];
            
        }
        
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.alignment                = NSTextAlignmentCenter;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[self darkerColorForColor:textColor] range:NSMakeRange(0, string.length)];
        
        
    }
    
    
    return attributedString;
}


-(NSArray *)getFactsDataArray {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *root = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:root options:NSJSONReadingMutableLeaves error:nil];
    
    NSArray *data = dict[@"stress"][_second_index];
    
    return data;
}


@end
