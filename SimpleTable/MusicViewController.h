//
//  MusicViewController.h
//  Mind & Wellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import <UIKit/UIKit.h>

@interface MusicViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) NSString *bg_image;
@property (nonatomic, strong) UIColor *navBarcolor;

@end
