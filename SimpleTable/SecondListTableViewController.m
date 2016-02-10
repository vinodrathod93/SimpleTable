//
//  SecondListTableViewController.m
//  SimpleTable
//
//  Created by Vinod Rathod on 14/01/16.
//
//

#import "SecondListTableViewController.h"
#import "SecondTableViewCell.h"
#import "DetailListViewController.h"
#import "AssessmentViewController.h"
#import "MusicViewController.h"
#import "ArticlesViewController.h"
#import "DoodleViewController.h"
#import "ReplaceViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondListTableViewController ()

@end

@implementation SecondListTableViewController {
    NSInteger _index;
    NSArray *_attributedArrays;
    NSArray *_backgroundImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _attributedArrays = @[
                          @[@"Behaviour", @"Psychological Issues", @"School environment"],
                          @[@"Issues faced",@"Body Image"],
                          @[@"Depression",@"Anxiety",@"Stress",@"Addiction",@"Relationship"]
                          ];
    
    _backgroundImages = @[
                          @"as1", @"as2", @"as3", @"as4", @"as5", @"as6", @"as7", @"as8", @"as9", @"as10", @"as11", @"as12", @"as13", @"as14"
                          ];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:self.bg_image]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:self.navBarcolor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data != nil ? self.data.count : 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    if (self.mainIndex == 4) {
        cell.listingLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18.f];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.listingLabel.textColor = [self darkerColorForColor:self.navBarcolor];
    cell.customView.layer.cornerRadius = 10.f;
    cell.customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    
    
    if (self.data) {
        cell.listingLabel.text = self.data[indexPath.section];
    }
    else
        cell.listingLabel.text = @"Listing 1";
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.mainIndex == 4) {
        return 120;
    }
    else
        return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10.f;
    }
    else
        return 5.f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _index  = indexPath.section;
    
    
    switch (self.mainIndex) {
        case 2:
        {
            AssessmentViewController *assessmentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"assessmentVC"];
            assessmentVC.backgroundImageString = _backgroundImages[indexPath.section];
            assessmentVC.title                 = self.data[indexPath.section];
            assessmentVC.details               = [self getJSONDataDictionary];
            assessmentVC.index                 = indexPath.section;
            
            if (indexPath.section == 5 || indexPath.section == 7 || indexPath.section == 8 || indexPath.section == 13) {
                assessmentVC.navBarColor = [UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0];
                
                
            }
            else if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 10 || indexPath.section == 11 || indexPath.section == 12) {
                assessmentVC.navBarColor = [UIColor colorWithRed:253/255.f green:216/255.f blue:53/255.f alpha:1.0];
            }
            else if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 9) {
                assessmentVC.navBarColor = [UIColor colorWithRed:255/255.f green:135/255.f blue:195/255.f alpha:1.0];
            }
            
            
            [self.navigationController pushViewController:assessmentVC animated:YES];
        }
            break;
            
        case 4:
        {
            if (indexPath.section == 0) {
                DoodleViewController *doodleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"doodleVC"];
                doodleVC.title = @"De-Stress";
                [self.navigationController pushViewController:doodleVC animated:YES];
            }
            else {
                ReplaceViewController *replaceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"replaceVC"];
                [self.navigationController pushViewController:replaceVC animated:YES];
            }
            
        }
            break;
            
        case 5:
        {
            ArticlesViewController *articlesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"articlesWebVC"];
            articlesVC.urlString = [self getJSONDataURL];
            
            [self.navigationController pushViewController:articlesVC animated:YES];
        }
            break;
            
        default:
        {
            DetailListViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailListVC"];
            detailVC.title = [self.data[indexPath.section] capitalizedString];
            detailVC.bg_image = self.bg_image;
            detailVC.second_index = indexPath.section;
            
            if (self.mainIndex == 0) {
                detailVC.attributedArray = _attributedArrays[indexPath.section];
            }
            
            detailVC.main_index     = self.mainIndex;
            
            NSArray *detailsArray = [self getJSONDataArray];
            detailVC.detailsArray = detailsArray;
            
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
    }
    
    
    
    if (self.mainIndex == 2) {
        
    }
    else {
        
        
    }
    
    
}

-(NSArray *)getJSONDataArray {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *root = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:root options:NSJSONReadingMutableLeaves error:nil];
    
    NSArray *data = dict[self.jsonKey][_index];
    
    return data;
}

-(NSDictionary *)getJSONDataDictionary {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *root = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:root options:NSJSONReadingMutableLeaves error:nil];
    
    NSDictionary *data = dict[self.jsonKey][_index];
    
    return data;
}

-(NSString *)getJSONDataURL {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *root = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:root options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *data = dict[self.jsonKey][_index];
    
    return data;
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

@end
