//
//  AskDoctorViewController.h
//  Mind & Wellness
//
//  Created by adverto on 31/01/16.
//
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface AskDoctorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *textfieldView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIButton *developerCreditButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *askTheQuestionButton;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;


@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end
