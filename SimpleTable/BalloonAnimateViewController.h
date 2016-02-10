//
//  BalloonAnimateViewController.h
//  MindnWellness
//
//  Created by Vinod Rathod on 10/02/16.
//
//

#import <UIKit/UIKit.h>

@interface BalloonAnimateViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *balloonImageView;
@property (weak, nonatomic) IBOutlet UIView *balloonContentView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *emoticon;
@property (weak, nonatomic) IBOutlet UIButton *letGoButton;

@property (strong, nonatomic) UIImage *balloonImage;
@property (strong, nonatomic) NSString *expressionText;
@property (strong, nonatomic) NSString *emoticonText;

@end
