//
//  DoodleViewController.m
//  MindnWellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import "DoodleViewController.h"
#import "ScratchViewController.h"

@interface DoodleViewController ()

@end

@implementation DoodleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self showInstructions];
    
    UIBarButtonItem *instructions = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"help"] style:UIBarButtonItemStylePlain target:self action:@selector(showInstructions)];
    
    self.navigationItem.rightBarButtonItem = instructions;
    
    
    [self.clearButton addTarget:self action:@selector(clearCanvas) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton addTarget:self action:@selector(goToScratchView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clearCanvas {
    [self.smoothLineView clear];
}


-(void)showInstructions {
    NSString *message = @"\n\n• Think of a negative emotion that comes easily to you, such as anger, sadness, fear or anxiety \n\n• Give that emotion a shape \n\n• Once you think of a shape, draw it and color it with all your energy \n\n• Make sure the color doesn't spill from the outline of the shape \n\n• Once you are done, press DONE";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions of Game" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)goToScratchView {
    
    
    
    
    
    ScratchViewController *scratchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScratchVC"];
    scratchVC.drawnImage = [self.smoothLineView doodleDrawnImage];
    
    [self.navigationController pushViewController:scratchVC animated:YES];
    
}

@end
