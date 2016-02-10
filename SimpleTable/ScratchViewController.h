//
//  ScratchViewController.h
//  MindnWellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import <UIKit/UIKit.h>

@interface ScratchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *foregroundImageView;

@property (strong, nonatomic) UIImage *drawnImage;
@end
