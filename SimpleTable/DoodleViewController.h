//
//  DoodleViewController.h
//  MindnWellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import <UIKit/UIKit.h>
#import "SmoothLineView.h"

@interface DoodleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet SmoothLineView *smoothLineView;
@end
