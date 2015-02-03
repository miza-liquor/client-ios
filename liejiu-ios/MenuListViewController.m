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
    UIAlertView *addConfirmAlert;
    NSDictionary *selectedMenuInfo;
    BOOL addSuccess;
}

@synthesize wineInfo;

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
    
    addSuccess = NO;
    addConfirmAlert = [[UIAlertView alloc] initWithTitle:@"确认添加该酒到所选的酒单吗？"
                                            message:nil
                                           delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:@"确认", nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void)viewWillAppear:(BOOL)animated
{
    addSuccess = NO;
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
    selectedMenuInfo = (NSDictionary *)[menuList objectAtIndex:indexPath.row];
    [addConfirmAlert show];
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

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        return;
        
    }
    
    if (addSuccess || !wineInfo)
    {
        [self.delegate selectedMenu:selectedMenuInfo];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSDictionary *params = @{
                             @"wine_id": (NSString *)[wineInfo objectForKey:@"id"],
                             @"menu_id": (NSString *)[selectedMenuInfo objectForKey:@"id"]
                            };
    
    [AppSetting httpPost:@"add/wine/menu" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            addSuccess = YES;
            [addConfirmAlert setTitle:@"添加成功"];
        } else {
            addSuccess = NO;
            [addConfirmAlert setTitle:msg];
        }
        [addConfirmAlert show];
    }];
}
@end
