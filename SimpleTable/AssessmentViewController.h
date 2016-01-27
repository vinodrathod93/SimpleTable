//
//  AssessmentViewController.h
//  SimpleTable
//
//  Created by Vinod Rathod on 25/01/16.
//
//

#import <UIKit/UIKit.h>
#import "SliderAssessmentTableViewCell.h"

@interface AssessmentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, SliderAssessmentDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *backgroundImageString;
@property (strong, nonatomic) UIColor *navBarColor;
@property (strong, nonatomic) NSDictionary *details;
@end
