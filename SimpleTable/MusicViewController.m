//
//  MusicViewController.m
//  Mind & Wellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MusicViewController ()
{
    AVAudioPlayer *player;
}
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:self.bg_image]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    
    self.backgroundView.image = [UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    
    [self.button addTarget:self action:@selector(flipButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"music"
                                                              ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                   error:nil];
    player.numberOfLoops = -1; //Infinite
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:self.navBarcolor];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [player stop];
}


-(void)flipButton:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    
    
    if (sender.isSelected) {
        [player play];
    } else
        [player pause];
}


@end
