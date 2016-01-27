//
//  SliderAssessmentTableViewCell.m
//  SimpleTable
//
//  Created by Vinod Rathod on 25/01/16.
//
//

#import "SliderAssessmentTableViewCell.h"

@implementation SliderAssessmentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    int discreteValue = roundl([sender value]); // Rounds float to an integer
    [sender setValue:(float)discreteValue];
    
    self.slidingValue.text = [NSString stringWithFormat:@"%d", discreteValue];
    
    if ([_sliderDelegate respondsToSelector:@selector(sliderChanged:)]) {
        [_sliderDelegate sliderChanged:self];
    }
}
@end
