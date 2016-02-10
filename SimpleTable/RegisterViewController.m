//
//  RegisterViewController.m
//  MindnWellness
//
//  Created by Vinod Rathod on 04/02/16.
//
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Registration";
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 24.f)];
    navigationBarView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:navigationBarView.frame];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"AvenirNext-Medium" size:17.f];
    title.textColor = [UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0];
    title.text = self.title;
    
    [navigationBarView addSubview:title];
    
    self.navigationItem.titleView = navigationBarView;
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.submitButton.layer.cornerRadius = 15.f;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton addTarget:self action:@selector(registerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameTF.delegate = self;
    self.emailTF.delegate = self;
    self.ageTF.delegate = self;
    self.cityTF.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - self.topLayoutGuide.length - self.bottomLayoutGuide.length);
}


-(void)registerButtonTapped {
    
    NSString *errorMessage = [self validateForm];
    if (errorMessage) {
        [self alertWithTitle:@"Error" message:errorMessage];
    }
    else {
        // Save
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setValue:@"Saved" forKey:@"user"];
        [user synchronize];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameTF]) {
        [self.nameTF becomeFirstResponder];
    }
    else if ([textField isEqual:self.emailTF]) {
        [self.emailTF becomeFirstResponder];
    }
    else if ([textField isEqual:self.ageTF]) {
        [self.ageTF becomeFirstResponder];
    }
    else if ([textField isEqual:self.cityTF]) {
        [self registerButtonTapped];
    }
    
    return YES;
}


-(NSString *)validateForm {
    NSString *errorMessage;
    
    if (![self.nameTF.text isValidName]) {
        errorMessage = @"Please enter a valid name";
    } else if (![self.emailTF.text isValidEmail]) {
        errorMessage = @"Please enter a valid email";
    } else if (![self.ageTF.text isValidName]) {
        errorMessage = @"Please enter a valid age";
    } else if (![self.cityTF.text isValidCity]) {
        errorMessage = @"Please enter a valid city";
    }
    
    return errorMessage;
    
}

-(void)alertWithTitle:(NSString *)status message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:status message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
