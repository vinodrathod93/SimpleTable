//
//  AskDoctorViewController.m
//  Mind & Wellness
//
//  Created by adverto on 31/01/16.
//
//

#import "AskDoctorViewController.h"

@implementation AskDoctorViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.textfieldView.layer.cornerRadius           = 10.f;
    self.addressView.layer.cornerRadius             = 10.f;
    self.developerCreditButton.layer.cornerRadius   = 10.f;
    self.askTheQuestionButton.layer.cornerRadius    = 10.f;
    
    self.textfieldView.layer.masksToBounds          = YES;
    self.addressView.layer.masksToBounds            = YES;
    self.developerCreditButton.layer.masksToBounds  = YES;
    self.askTheQuestionButton.layer.masksToBounds   = YES;
    
    
    
    self.textView.text = @"Dr Rachna K Singh \n Mobile: : +91 9810021945 \n Email : info@themindandwellness.com \n Address : M-65, Greater Kailash, Part 1, \n New Delhi - 110065";
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}

@end
