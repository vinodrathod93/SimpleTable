//
//  SliderAssessmentTableViewCell.h
//  SimpleTable
//
//  Created by Vinod Rathod on 25/01/16.
//
//

#import <UIKit/UIKit.h>

@interface SliderAssessmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *slidingValue;
@end
