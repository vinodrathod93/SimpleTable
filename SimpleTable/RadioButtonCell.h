//
//  RadioButtonCell.h
//  SimpleTable
//
//  Created by Vinod Rathod on 28/01/16.
//
//

#import <UIKit/UIKit.h>
#import <TNRadioButtonGroup/TNRadioButtonGroup.h>

@interface RadioButtonCell : UITableViewCell

@property (nonatomic, strong) TNRadioButtonGroup *optionsGroup;
@property (nonatomic, strong) UILabel *question;
@end
