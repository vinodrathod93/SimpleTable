//
//  MSTableViewCell.h
//  SimpleTable
//
//  Created by Vinod Rathod on 14/01/16.
//
//

#import <UIKit/UIKit.h>

@interface MSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@end
