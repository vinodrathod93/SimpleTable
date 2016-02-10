//
//  ArticlesViewController.h
//  Mind & Wellness
//
//  Created by Vinod Rathod on 03/02/16.
//
//

#import <UIKit/UIKit.h>

@interface ArticlesViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSString *urlString;
@end
