//
//  ReplaceViewController.m
//  MindnWellness
//
//  Created by Vinod Rathod on 04/02/16.
//
//

#import "ReplaceViewController.h"
#import "BalloonAnimateViewController.h"

@interface ReplaceViewController ()<UIActionSheetDelegate>

@end

@implementation ReplaceViewController {
    NSArray *emoticon;
    NSArray *messages;
    NSInteger _indexValue;
    
    NSString *expressionString;
    NSString *expressionEmoticon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Replace";
    
    
    emoticon = @[
                 @[
                     @"Angry 😠",
                     @"Sad 😨",
                     @"Irritated 😰",
                     @"Frustrated 😕",
                     @"Depressed 😢 ",
                     @"Low 😞",
                     @"Gloomy 😥"
                     ],
                 @[
                     @"blue",
                     @"red",
                     @"green",
                     @"yellow",
                     @"orange"
                     ]
                 ];
    
    messages = @[
                 @"Identify a predominant negative emoticon that you are experiencing recently or since the past 6 weeks.", @"Now select a colour for the balloon that relates most closely to your current emotion.", @"Now sit back and while looking at the balloon, think about the experience that reminds you of this emotion the most. Notice how this negative experience has impacted you.",
                 @"Our negative emotions are a result of us holding on these negative memories and experiences. Thus, inorder to transform your emotions we need to let go of these negative emotions. \n Click on the button to release the balloon in which you are holding on to your negative emotions."
                 ];
    
    
    // Background Image
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"only"]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    self.backgroundImageView.image = [UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    // Navigation Bar Tint Color
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    // Next Button
    self.nextButtton.layer.cornerRadius = 10.f;
    self.nextButtton.layer.masksToBounds = YES;
    [self.nextButtton addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Next Button Logic Method
    _indexValue = 0;
    [self loadDataForIndex:_indexValue];
    
    
    // Bar Button Image
    UIBarButtonItem *instructions = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"help"] style:UIBarButtonItemStylePlain target:self action:@selector(showInstructions)];
    self.navigationItem.rightBarButtonItem = instructions;
    
    [self.emoticonButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)buttonPressed:(UIButton *)sender {
    
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:nil message:@"Select Emoticon" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *firstArray = emoticon[_indexValue];
    
    for (int i=0; i< firstArray.count; i++) {
        NSString *value = [NSString stringWithFormat:@"%@", emoticon[_indexValue][i]];
        value = value.capitalizedString;
        
        UIAlertAction *titleAction = [UIAlertAction actionWithTitle:value style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            NSString *string = [NSString stringWithFormat:@"%@  ▾", emoticon[_indexValue][i]];
            sender.titleLabel.text = string.capitalizedString;
            
            
            if (_indexValue == 0) {
                NSArray *array = [emoticon[_indexValue][i] componentsSeparatedByString:@" "];
                expressionString = [array firstObject];
                expressionEmoticon = [array lastObject];
            }
            
            if (_indexValue == 1) {
                self.balloonImageView.image = [UIImage imageNamed:emoticon[_indexValue][i]];
            }
            
        }];
        
        [alertController addAction:titleAction];
    }
    
    
    alertController.popoverPresentationController.sourceView = sender;
    alertController.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)showInstructions {
    
    NSString *message = messages[_indexValue];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions of Game" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)gotoNext {
    _indexValue++;
    
    
    
    if (_indexValue > 1) {
        
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Interpretation" message:@"In order to feel better it is important to think better! Positive Goals lead to Positive Language and Positive Language leads to a happier you." preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        }];
//        
//        [alert addAction:ok];
//        
//        [self presentViewController:alert animated:YES completion:nil];
        
        
        BalloonAnimateViewController *balloonVC = [self.storyboard instantiateViewControllerWithIdentifier:@"balloonAnimateVC"];
        balloonVC.balloonImage = self.balloonImageView.image;
        balloonVC.expressionText = expressionString;
        balloonVC.emoticonText = expressionEmoticon;
        
        [self.navigationController pushViewController:balloonVC animated:YES];
        
        
        
    }
    else {
        [self showInstructions];
        [self loadDataForIndex:_indexValue];
    }
    
}


-(void)loadDataForIndex:(NSInteger)index {
    
    
    NSString *title = [NSString stringWithFormat:@"%@  ▾              ", emoticon[index][0]];
    title = title.capitalizedString;
    
    
    if (index == 0) {
        
        NSArray *array = [emoticon[index][0] componentsSeparatedByString:@" "];
        expressionString = [array firstObject];
        expressionEmoticon = [array lastObject];

    }
    
    [self.emoticonButton setTitle:title forState:UIControlStateNormal];
    [self.emoticonButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    if (index == 0) {
        NSString *image_name = emoticon[1][0];
        self.balloonImageView.image = [UIImage imageNamed:image_name];
    }
    
    if (index == 1) {
        
        NSString *image_name = emoticon[index][0];
        self.balloonImageView.image = [UIImage imageNamed:image_name];
    }
    
    if (index == 2) {
        [self.nextButtton setTitle:@"LET GO" forState:UIControlStateNormal];
    }
    
}

@end
