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
#import "AppSetting.h"

@interface WineCenterViewController ()

@end

@implementation WineCenterViewController
{
    WineCenterHeadTableViewCell *headerCell;
    NSArray *wineList;
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
    wineList = @[@"1",@"2",@"3",@"4",@"5"];
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
    
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? [headerCell getRowHeight] : 168;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    [self performSegueWithIdentifier:@"wineDetail" sender:self];
}

- (void) addWineToMenuList:(NSString *)wineID
{
    [self performSegueWithIdentifier:@"addToMenu" sender:self];
}

- (void) submitSearchBox:(NSString *)keywork
{
}

- (void) clickOnCategoryBtn:(NSDictionary *)category
{
    
}

- (void) categoryDataReady
{
    [self.tableView reloadData];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
