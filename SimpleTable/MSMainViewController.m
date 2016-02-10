//
//  MSMainViewController.m
//  SimpleTable
//
//  Created by Vinod Rathod on 14/01/16.
//
//

#import "MSMainViewController.h"
#import "MSTableViewCell.h"
#import "AskDoctorTableViewCell.h"
#import "SecondListTableViewController.h"
#import "AskDoctorViewController.h"
#import "MusicViewController.h"
#import "RegisterViewController.h"

@interface MSMainViewController ()

@end

@implementation MSMainViewController
{
    NSMutableArray *_labels;
    int _middle;
    int _decrementFrom;
    NSArray *_allData;
    NSArray *_icons;
    NSArray *_backgrounds;
    NSArray *_jsonKeys;
    NSInteger _mainIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Navigation Title
    self.title = @"Stress Therapy";
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([user valueForKey:@"user"] == nil) {
        RegisterViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:registerVC];
        navigation.navigationBar.tintColor = [UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0];
        
        
        [self presentViewController:navigation animated:YES completion:nil];
    }
    
    
    
    
    
    
    
    
    
    _labels = [NSMutableArray arrayWithObjects:@"Did you know", @"Myths & Facts", @"Assesments", @"Find a Solution", @"Stress Busters", @"Articles", @"Music", nil];
    _icons  = @[ @"l1", @"l2", @"l3", @"l4", @"l3", @"l2", @"l1" ];
    _backgrounds = @[ @"didyouknow.png", @"mythsandfacts.png", @"as.png", @"findasolution.png", @"stressbusters.png", @"as1.png", @"music.png"];
    _jsonKeys = @[@"dyk", @"mf", @"assessment", @"solution", @"stress", @"articles", @"music"];
    
    _middle = ceilf(_labels.count/2.f);
    _decrementFrom = _middle;
    
    
    CIImage *image = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef reference = [context createCGImage:image fromRect:image.extent];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:reference scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp]];

    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    _allData = [self getPlistDataArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0]];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return section == 0 ? [_labels count] : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"MSSimpleTableItem";
    static NSString *askDoctorIdentifier   = @"askDoctorCellIdentifier";
    
    
    
    NSString *cellIdentifier = indexPath.section == 0 ? simpleTableIdentifier : askDoctorIdentifier;
    
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.section == 0) {
        [self configureSimpleCell:cell forIndexPath:indexPath];
    }
    else {
        [self configureAskDoctorCell:cell forIndexPath:indexPath];
    }
    
    
    
    return cell;
}


-(void)configureSimpleCell:(MSTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.name.text = [_labels objectAtIndex:indexPath.row];
    cell.iconView.image = [UIImage imageNamed:_icons[indexPath.row]];
    cell.iconView.layer.cornerRadius = cell.iconView.frame.size.height/2.f;
    cell.iconView.layer.masksToBounds = YES;
    
    if (self.view.frame.size.width <= 320) {
        cell.indentationWidth = 30;
    }
    else
        cell.indentationWidth = 40;
}


-(void)configureAskDoctorCell:(AskDoctorTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.askDoctorLabel.layer.cornerRadius = 20.f;
    cell.askDoctorLabel.layer.masksToBounds = YES;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.f;
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        if (indexPath.row >= _middle) {
            
            if (indexPath.row == _middle)
                return _middle - 1;
            else if (indexPath.row == _middle + 1)
                return _middle - 2;
            else if (indexPath.row == _middle + 2)
                return _middle - 3;
            
            NSLog(@"Row is %ld and returns %d", (long)indexPath.row, _decrementFrom);
            
            return _decrementFrom;
        }
        else {
            NSLog(@"Else Row is %ld and returns %ld", (long)indexPath.row, (long)indexPath.row + 1);
            return indexPath.row+1;
        }
    
        
        
    }
    else
        return 0;
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 6) {
            MusicViewController *musicVC = [self.storyboard instantiateViewControllerWithIdentifier:@"musicVC"];
            musicVC.title = _labels[indexPath.row];
            musicVC.bg_image = _backgrounds[indexPath.row];
            musicVC.navBarcolor = [UIColor colorWithRed:253/255.f green:216/255.f blue:53/255.f alpha:1.0];
            [self.navigationController pushViewController:musicVC animated:YES];
        }
        else {
            
            SecondListTableViewController *secondTableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"secondListTableVC"];
            
            secondTableVC.title     = _labels[indexPath.row];
            secondTableVC.bg_image  = _backgrounds[indexPath.row];
            secondTableVC.data      = _allData[indexPath.row];
            secondTableVC.jsonKey   = _jsonKeys[indexPath.row];
            secondTableVC.mainIndex = indexPath.row;
            
            if (indexPath.row == 0 || indexPath.row == 2) {
                secondTableVC.navBarcolor = [UIColor colorWithRed:32/255.f green:150/255.f blue:243/255.f alpha:1.0];
                
                
            }
            else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6) {
                secondTableVC.navBarcolor = [UIColor colorWithRed:253/255.f green:216/255.f blue:53/255.f alpha:1.0];
            }
            else if (indexPath.row == 5) {
                secondTableVC.navBarcolor = [UIColor colorWithRed:255/255.f green:135/255.f blue:195/255.f alpha:1.0];
            }
            
            
            
            [self.navigationController pushViewController:secondTableVC animated:YES];
            
            
        }
        
        
    }
    else {
        
        AskDoctorViewController *askDoctor      = [self.storyboard instantiateViewControllerWithIdentifier:@"askDoctorVC"];
        askDoctor.title                         = @"Contact Form";
        [self.navigationController pushViewController:askDoctor animated:YES];
    }
    
    
}


-(NSArray *)getPlistDataArray {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSArray *data = root[@"data"];
    
    return data;
}

@end
