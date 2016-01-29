//
//  RadioButtonCell.m
//  SimpleTable
//
//  Created by Vinod Rathod on 28/01/16.
//
//

#import "RadioButtonCell.h"

@implementation RadioButtonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // all stuff
        
        _question = [[UILabel alloc] init];
        _question.font = [UIFont fontWithName:@"AvenirNext-Medium" size:15.f];
        _question.numberOfLines = 0;
        
        [self.contentView addSubview:_question];
        
        
        
        _optionsGroup = [[TNRadioButtonGroup alloc] init];
        [self.contentView addSubview:_optionsGroup];
        
        
    }
    
    return self;
}

@end
