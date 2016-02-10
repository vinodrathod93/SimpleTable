//
//  RadioButtonCell.m
//  SimpleTable
//
//  Created by Vinod Rathod on 28/01/16.
//
//

#import "RadioButtonCell.h"

@interface RadioButtonCell ()


@end

@implementation RadioButtonCell

- (void)awakeFromNib {
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // all stuff
        
        
        
        
        self.radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.radioButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.f]];
        [self.radioButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.radioButton.titleLabel.numberOfLines = 0;
        [self.radioButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.radioButton setImage:[UIImage imageNamed:@"radio-off"] forState:UIControlStateNormal];
        [self.radioButton setImage:[UIImage imageNamed:@"radio-on"] forState:UIControlStateSelected];
        [self.radioButton addTarget:self action:@selector(radioButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.radioButton];
        
        
    }
    
    return self;
}


-(void)radioButtonTouched {
    
    if (_radioButton.isSelected == YES) {
        return;
    }
    else {
        [self selectRadioButton];
        [_delegate radioButtonCellDidSelect:self];
    }
    
}

-(void)selectRadioButton {
    
    _radioButton.selected = YES;
}

-(void)deselectRadioButton {
    
    _radioButton.selected = NO;
}


@end
