//
//  RadioButtonCell.h
//  SimpleTable
//
//  Created by Vinod Rathod on 28/01/16.
//
//

#import <UIKit/UIKit.h>

@class RadioButtonCell;

@protocol RadioButtonCellDelegate <NSObject>

-(void)radioButtonCellDidSelect:(RadioButtonCell *)selectedCell;

@end

@interface RadioButtonCell : UITableViewCell

@property (nonatomic, strong) UIButton *radioButton;

@property (nonatomic, weak) id <RadioButtonCellDelegate> delegate;
-(void)deselectRadioButton;
-(void)selectRadioButton;

@end
