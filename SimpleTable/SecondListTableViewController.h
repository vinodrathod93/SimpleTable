//
//  SecondListTableViewController.h
//  SimpleTable
//
//  Created by Vinod Rathod on 14/01/16.
//
//

#import <UIKit/UIKit.h>

@interface SecondListTableViewController : UITableViewController

@property (nonatomic, strong) UIColor *navBarcolor;
@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSString *bg_image;
@property (nonatomic, strong) NSString *jsonKey;

@property (nonatomic) NSInteger mainIndex;
@end
