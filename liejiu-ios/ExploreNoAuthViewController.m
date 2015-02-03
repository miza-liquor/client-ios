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
#import "TopImageViewController.h"
#import "MenuDetailViewController.h"
#import "LoadingTableViewCell.h"
#import "AppSetting.h"

@interface ExploreNoAuthViewController ()

@end

@implementation ExploreNoAuthViewController
{
    UIAlertView *loginAlert;
    NSArray *topMenus;
    NSString *selectedTopImageUrl;
    NSDictionary *selectedMenuInfo;
    TopImageTableViewCell *topImageCell;
    LoadingTableViewCell *loadingCell;
    BOOL isLoading;
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
    
    topMenus = @[];
    isLoading = YES;
    [AppSetting topBarStyleSetting:self];
    loginAlert = [[UIAlertView alloc] initWithTitle:@"请登录"
                                           message:@"详情内容需要用户登录"
                                           delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:@"登录", nil];
    
    NSArray *loadingNibTab = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
    loadingCell = [loadingNibTab objectAtIndex:0];
    // loading on auth data
    [self loadNotAuthData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void) loadNotAuthData
{
    [AppSetting httpGet:@"guest" parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success)
        {
            isLoading = NO;
            NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
            topMenus = (NSArray *)[data objectForKey:@"top_menu"];
            [self initHeader:(NSArray *)[data objectForKey:@"top_image"]];
            [self.tableView reloadData];
        }
    }];
}

- (void) initHeader:(NSArray *) headerData
{
    // init static slide cell
    NSArray *nibTab = [[NSBundle mainBundle] loadNibNamed:@"TopImageTableViewCell" owner:self options:nil];
    topImageCell = [nibTab objectAtIndex:0];
    topImageCell.delegate = self;
    [topImageCell setSildeViewImages: headerData];
    topImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topMenus count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading)
    {
        return loadingCell;
    }
    if (indexPath.row == 0)
    {
        return topImageCell;
    }
    
    static NSString *simpleTableIdentifierList = @"TopMenuTableViewCell";
    TopMenuTableViewCell *cell = (TopMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifierList];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopMenuTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *info = (NSDictionary *)[topMenus objectAtIndex:indexPath.row - 1];
    [cell setTopMenuData:info];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 400 : 126;
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
