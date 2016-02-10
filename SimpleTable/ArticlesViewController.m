//
//  ArticlesViewController.m
//  Mind & Wellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import "ArticlesViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ArticlesViewController ()

@end

@implementation ArticlesViewController{
    MBProgressHUD *_hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.webView.delegate = self;
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.center = self.view.center;
    _hud.labelText = @"Loading...";
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [_hud hide:YES];
}

@end
