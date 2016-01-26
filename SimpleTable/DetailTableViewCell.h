//
//  DetailTableViewCell.h
//  SimpleTable
//
//  Created by Vinod Rathod on 22/01/16.
//
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *roundedView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
