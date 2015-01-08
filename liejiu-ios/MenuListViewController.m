//
//  MenuListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "MenuListViewController.h"
#import "NewMenuViewController.h"
#import "UserMenuTableViewCell.h"
#import "AppSetting.h"

@interface MenuListViewController ()

@end

@implementation MenuListViewController
{
    NSArray *menuList;
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
    
    menuList = @[];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getData];
}

- (void) getData
{
    NSDictionary *userInfo = (NSDictionary *)[AppSetting getCache:@"userInfo"];
    NSString *userID = (NSString *)[userInfo objectForKey:@"id"];
    NSString *cacheName = [NSString stringWithFormat:@"user-%@-mymenu", userID];
    NSArray *cache = (NSArray *)[AppSetting getCache:cacheName];
    NSString *url = [NSString stringWithFormat:@"mymenu/%@", userID];
    
    if (cache == Nil)
    {
        [AppSetting httpGet:url parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            if (success == YES)
            {
                menuList = (NSArray *)[response objectForKey:@"data"];
                [AppSetting setCache:cacheName value:menuList];
                [self.tableView reloadData];
            }
        }];
    } else {
        menuList = cache;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    return [menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *menuTableIdentifier = @"UserMenuTableViewCell";
    UserMenuTableViewCell *menuCell = (UserMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:menuTableIdentifier];
    if (menuCell == nil)
    {
        NSArray *menuNib = [[NSBundle mainBundle] loadNibNamed:menuTableIdentifier owner:self options:nil];
        menuCell = [menuNib objectAtIndex:0];
    }
    
    [menuCell setUserMenu:[menuList objectAtIndex:indexPath.row]];
    return menuCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - new menu delegate
- (void) addNewMenu:(NSString *)menuID
{
    [self.tableView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newMenu"])
    {
        NewMenuViewController *categoryView = segue.destinationViewController;
        categoryView.delegate = self;
    }
}
@end
