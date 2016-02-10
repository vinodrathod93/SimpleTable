//
//  BalloonAnimateViewController.m
//  MindnWellness
//
//  Created by Vinod Rathod on 10/02/16.
//
//

#import "BalloonAnimateViewController.h"
#import "ReplaceViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BalloonAnimateViewController ()

@end

@implementation BalloonAnimateViewController {
    BOOL showAnotherAlert;
    AVAudioPlayer *player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Background Image
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"fly"]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    self.backgroundImage.image = [UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    
    self.title = @"Replace";
    
    self.letGoButton.layer.cornerRadius = 10.f;
    self.letGoButton.layer.masksToBounds = YES;
    [self.letGoButton addTarget:self action:@selector(letGoAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.balloonImageView.image = self.balloonImage;
    self.label.text = self.expressionText;
    self.emoticon.text = self.emoticonText;
    
    
    [self showInstructions];
    showAnotherAlert = YES;
    
    UIBarButtonItem *instructions = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"help"] style:UIBarButtonItemStylePlain target:self action:@selector(showInstructions)];
    
    self.navigationItem.rightBarButtonItem = instructions;
    
    // Remove the replace view controller in navigationcontroller array
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    for(UIViewController* vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[ReplaceViewController class]]) {
            [viewControllers removeObject:vc];
            break;
        }
        
    }
    self.navigationController.viewControllers = [NSArray arrayWithArray:viewControllers];
    
    
    // Play Music
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"fly_music"
                                                              ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                    error:nil];
    player.numberOfLoops = -1; //Infinite
    [player play];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [player stop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showInstructions {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions of Game" message:@"Now sit back and while looking at the balloon, think about the experience that reminds you of this emotion the most. Notice how this negative experience has impacted you."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag = 120;
    
    [alert show];
}


-(void)showMessage {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions of Game" message:@"Our negative emotions are a result of us holding on these negative memories and experiences. Thus, inorder to transform your emotions we need to let go of these negative emotions. \n Click on the button to release the balloon in which you are holding on to your negative emotions."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    showAnotherAlert = NO;
}



-(void)letGoAction {
    
    
    int lowerBound = 5;
    int upperBound = self.view.frame.size.width;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    [UIView animateWithDuration:2.0f animations:^{
        
        self.balloonImageView.frame = CGRectMake(rndValue, - self.balloonImageView.frame.size.height, self.balloonImageView.frame.size.width, self.balloonImageView.frame.size.height);
        
        self.balloonContentView.frame = CGRectMake(rndValue, - self.balloonContentView.frame.size.height, self.balloonContentView.frame.size.width, self.balloonContentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        NSLog(@"Animation Complete");
        
        
        [self.letGoButton removeFromSuperview];
        [self.balloonContentView removeFromSuperview];
        [self.balloonImageView removeFromSuperview];
        
        
        [UIView transitionWithView:self.backgroundImage duration:3.0f options:UIViewAnimationOptionTransitionCurlDown animations:^{
            CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"fly1"]];
            CIContext *context = [CIContext contextWithOptions:nil];
            CGImageRef reference = [context createCGImage:image fromRect:image.extent];
            self.backgroundImage.image = [UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
        } completion:nil];
        
        
        
        
    }];
    
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    
    if (alertView.tag == 120) {
        
        if (showAnotherAlert) {
            [self showMessage];
        }
        
    }
}

@end
