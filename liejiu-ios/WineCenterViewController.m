//
//  WineCenterViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "WineCenterViewController.h"
#import "WineCenterHeadTableViewCell.h"
#import "WineCenterListTableViewCell.h"
#import "WineDetailViewController.h"
#import "MenuListViewController.h"
#import "AppSetting.h"

@interface WineCenterViewController ()

@end

@implementation WineCenterViewController
{
    WineCenterHeadTableViewCell *headerCell;
    NSArray *wineList;
    NSDictionary *selectedCategory;
    NSString *keyword;
    NSDictionary *selectedWine;
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
    
    UIBarButtonItem *drawerBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_drawer"] style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
    self.navigationItem.leftBarButtonItem = drawerBtn;
    [AppSetting drawToolBar:self];
    [self initStaticCell];
    wineList = @[];
    [self loadWineData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void) loadWineData
{
    NSArray* defaultList = (NSArray *)[AppSetting getCache:@"wineSearchDefaultList"];
    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if ([keyword length] == 0 && selectedCategory == nil && defaultList != nil)
    {
        wineList = defaultList;
        [self.tableView reloadData];
        return;
        
    }
    
    NSString *url = (keyword != nil) ? [NSString stringWithFormat:@"search/wine/%@", keyword] : @"search/wine";
    NSDictionary *parameters = (selectedCategory != nil) ? @{@"category": (NSString *)[selectedCategory objectForKey:@"id"]} : nil;
    
    [AppSetting httpGet:url parameters:parameters callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            wineList = (NSArray *)[response objectForKey:@"data"];
            if (keyword == nil && selectedCategory == nil)
            {
                [AppSetting setCache:@"wineSearchDefaultList" value:wineList];
            }

            [self.tableView reloadData];
        }
    }];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void) initStaticCell
{
    NSArray *nibTab = [[NSBundle mainBundle] loadNibNamed:@"WineCenterHeadTableViewCell" owner:self options:nil];
    headerCell = [nibTab objectAtIndex:0];
    headerCell.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wineList count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return headerCell;
    }
    static NSString *simpleTableIdentifier = @"WineCenterListTableViewCell";
    WineCenterListTableViewCell *cell = (WineCenterListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary* wineInfo = (NSDictionary *)[wineList objectAtIndex:indexPath.row - 1];
    [cell setData:wineInfo];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [headerCell getRowHeight];
    } else {
        NSDictionary* wineInfo = (NSDictionary *)[wineList objectAtIndex:indexPath.row - 1];
        NSArray *users = (NSArray *)[wineInfo objectForKey:@"drink_user"];
        return [users count] == 0 ? 90 : 140;
    }

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    selectedWine = (NSDictionary *)[wineList objectAtIndex:indexPath.row-1];
    [self performSegueWithIdentifier:@"wineDetail" sender:self];
}

- (void) addWineToMenuList:(NSString *)wineID
{
    [self performSegueWithIdentifier:@"addToMenu" sender:self];
}

- (void) submitSearchBox:(NSString *)kw
{
    keyword = kw;
    [self loadWineData];
}

- (void) clickOnCategoryBtn:(NSDictionary *)category
{
    
}

- (void) categoryDataReady
{
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"wineDetail"])
    {
        WineDetailViewController *vc = segue.destinationViewController;
        vc.basicInfo = selectedWine;
    } else if ([segue.identifier isEqualToString:@"addToMenu"])
    {
        MenuListViewController *menuVC = segue.destinationViewController;
        menuVC.wineInfo = selectedWine;
    }
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
