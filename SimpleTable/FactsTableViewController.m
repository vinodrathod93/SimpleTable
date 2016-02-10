//
//  FactsTableViewController.m
//  MindnWellness
//
//  Created by Vinod Rathod on 04/02/16.
//
//

#import "FactsTableViewController.h"
#import "FactsTableViewCell.h"

@interface FactsTableViewController ()

@end

@implementation FactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"factsDetailCellIdentifier" forIndexPath:indexPath];
    
//    NSString *string = self.factDetails[self.index];
    
    // Configure the cell...
    cell.backgroundColor = [UIColor clearColor];
    cell.roundedView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    cell.roundedView.layer.cornerRadius = 10.f;
    cell.textView.backgroundColor = [UIColor clearColor];
    cell.textView.text = self.factDetails;
    
    UIColor *textColor              = [UIColor colorWithRed:34/255.f green:167/255.f blue:240/255.f alpha:1.0];
    
    
    cell.textView.textColor       = [self darkerColorForColor:textColor];
    cell.textView.editable      = NO;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *string = self.factDetails;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                          NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16.f]
                                                                                                          }];
    
    NSInteger height = [self findHeightForText:attributedString havingWidth:self.view.frame.size.width-52 andFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16.f]].height;
    
    return height;
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


- (CGSize)findHeightForText:(NSAttributedString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        size = CGSizeMake(ceilf(frame.size.width), ceilf(frame.size.height) + 53.5f);
    }
    return size;
}



@end
