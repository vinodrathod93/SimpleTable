//
//  AskDoctorViewController.m
//  Mind & Wellness
//
//  Created by adverto on 31/01/16.
//
//

#import "AskDoctorViewController.h"
#import <MessageUI/MessageUI.h>

@interface AskDoctorViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation AskDoctorViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Background Image
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"askadoctor"]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    self.backgroundImageView.image = [UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.textfieldView.backgroundColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    self.addressView.backgroundColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    
    self.textfieldView.layer.cornerRadius           = 15.f;
    self.addressView.layer.cornerRadius             = 15.f;
    self.developerCreditButton.layer.cornerRadius   = 15.f;
    self.askTheQuestionButton.layer.cornerRadius    = 15.f;
    
    self.textfieldView.layer.masksToBounds          = YES;
    self.addressView.layer.masksToBounds            = YES;
    self.developerCreditButton.layer.masksToBounds  = YES;
    self.askTheQuestionButton.layer.masksToBounds   = YES;
    
    
    
    self.textView.text = @" Dr Rachna K Singh \n Mobile: : +91 9810021945 \n Email : info@themindandwellness.com \n Address : M-65, Greater Kailash, Part 1, \n New Delhi - 110065";
    
    
    
    
    [self.askTheQuestionButton addTarget:self action:@selector(prepareMail) forControlEvents:UIControlEventTouchUpInside];
    [self.developerCreditButton addTarget:self action:@selector(alertDeveloperCredits) forControlEvents:UIControlEventTouchUpInside];
    
    
}



-(void)prepareMail {
    
    NSString *emailTitle = self.questionTextField.text;
    // Email Content
    NSString *messageBody = self.descriptionTextField.text;
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@themindandwellness.com"];
    
    MFMailComposeViewController *mailComposerVC = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]) {
        mailComposerVC.mailComposeDelegate = self;
        [mailComposerVC setSubject:emailTitle];
        [mailComposerVC setMessageBody:messageBody isHTML:NO];
        [mailComposerVC setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mailComposerVC animated:YES completion:NULL];
    }
}


-(void)alertDeveloperCredits {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Developer Credits" message:@"Pranav Jain \n Mobile: +91 9971803309 \n Email: contact@pranavjain.me"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end
