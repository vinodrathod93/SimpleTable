//
//  DetailListViewController.h
//  SimpleTable
//
//  Created by Vinod Rathod on 19/01/16.
//
//

#import <UIKit/UIKit.h>

@interface DetailListViewController : UITableViewController

@property (nonatomic, strong) NSString *bg_image;
@property (nonatomic, strong) NSArray *detailsArray;
@property (nonatomic, strong) NSArray *attributedArray;
@property (nonatomic)   NSInteger main_index;

@property (nonatomic)   NSInteger second_index;

@property (nonatomic, strong) UIColor *textColor;
@end
