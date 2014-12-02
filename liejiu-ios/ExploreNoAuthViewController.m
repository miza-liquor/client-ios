//
//  ExploreNoAuthViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "ExploreNoAuthViewController.h"
#import "TopImageTableViewCell.h"
#import "TopMenuTableViewCell.h"

@interface ExploreNoAuthViewController ()

@end

@implementation ExploreNoAuthViewController
{
    NSArray *recipes;
    UIAlertView *loginAlert;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    loginAlert = [[UIAlertView alloc] initWithTitle:@"请登录"
                                           message:@"详情内容需要用户登录"
                                           delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:@"登录", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *simpleTableIdentifier = @"TopImageTableViewCell";
        TopImageTableViewCell *cell = (TopImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopImageTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    static NSString *simpleTableIdentifierList = @"TopMenuTableViewCell";
    TopMenuTableViewCell *cell = (TopMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifierList];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopMenuTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 320 : 140;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0)
    {
        [loginAlert show];
    }
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self goToLoginPage];
    }
}

#pragma mark - Top image cell delegate
- (void) gotoTopBannerDetail: (NSString *) bannerURL
{
    [loginAlert show];
}
- (void) gotoTopSectionList: (NSString *) segueName
{
    [loginAlert show];
}

- (IBAction)login:(id)sender
{
    [self goToLoginPage];
}

- (void) goToLoginPage
{
    [self performSegueWithIdentifier:@"login" sender:self];
}

@end
