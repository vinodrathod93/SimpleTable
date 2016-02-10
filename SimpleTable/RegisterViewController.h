//
//  RegisterViewController.h
//  MindnWellness
//
//  Created by Vinod Rathod on 04/02/16.
//
//

#import <UIKit/UIKit.h>
#import "NSString+Validation.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@end
