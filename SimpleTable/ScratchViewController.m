//
//  ScratchViewController.m
//  MindnWellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import "ScratchViewController.h"
#import "DoodleViewController.h"

@interface ScratchViewController ()
{
    CGPoint previousPoint;
    CGPoint currentPoint;
}
@end

@implementation ScratchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0]];
    UIBarButtonItem *instructions = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"help"] style:UIBarButtonItemStylePlain target:self action:@selector(showInstructions)];
    
    self.navigationItem.rightBarButtonItem = instructions;
    
    
    
    [self showInstructions];
    
    
    // Remove the drawing canvas view in navigationcontroller array
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    for(UIViewController* vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[DoodleViewController class]]) {
            [viewControllers removeObject:vc];
            break;
        }
        
    }
    self.navigationController.viewControllers = [NSArray arrayWithArray:viewControllers];
    
    

    
    // Show drawn Image
    self.foregroundImageView.image = self.drawnImage;
    
    
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"smile"]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    
    self.backgroundImageView.image = [UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showInstructions {
    NSString *message = @"Now just erase your negative emotion with your finger, as you begin doing so you will start feeling light.";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions of Game" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    previousPoint = [touch locationInView:self.view];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    UITouch *touch = [touches anyObject];
    currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    //This may not be necessary if you are just erasing, in my case I am
    //adding lines repeatedly to an image so you may want to experiment with moving
    //this to touchesBegan or something. Which of course would also require the begin
    //graphics context etc.
    
    [self.foregroundImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    CGContextSaveGState(UIGraphicsGetCurrentContext());
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 40.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.25, 0.25, 0.25, 1.0);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, previousPoint.x, previousPoint.y);
    CGPathAddLineToPoint(path, nil, currentPoint.x, currentPoint.y);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    CGContextAddPath(UIGraphicsGetCurrentContext(), path);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.foregroundImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    previousPoint = currentPoint;
}

@end
