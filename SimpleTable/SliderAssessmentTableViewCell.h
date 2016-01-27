//
//  SliderAssessmentTableViewCell.h
//  SimpleTable
//
//  Created by Vinod Rathod on 25/01/16.
//
//

#import <UIKit/UIKit.h>

@protocol SliderAssessmentDelegate <NSObject>

-(void)sliderChanged:(id)self;

@end

@interface SliderAssessmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *slidingValue;

- (IBAction)sliderValueChanged:(id)sender;

@property (weak, nonatomic) id<SliderAssessmentDelegate>sliderDelegate;
@end
