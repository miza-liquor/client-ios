//
//  MenuDetailViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "MenuDetailViewController.h"
#import "MenuDetailHeaderTableViewCell.h"
#import "MenuWineImagesTableViewCell.h"
#import "LoadingTableViewCell.h"
#import "WineDetailViewController.h"
#import "AppSetting.h"

@interface MenuDetailViewController ()

@end

@implementation MenuDetailViewController
{
    MenuDetailHeaderTableViewCell *headerCell;
    LoadingTableViewCell *loadingCell;
    NSArray *wineList;
    NSDictionary *selectedWineInfo;
    BOOL isLoading;
}
@synthesize menuInfo;

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
    
    isLoading = YES;
    wineList = @[];
    [AppSetting drawToolBar:self];
    [self initHeader];
    [self getMenuWines];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void) initHeader
{
    NSArray *nibTab = [[NSBundle mainBundle] loadNibNamed:@"MenuDetailHeaderTableViewCell" owner:self options:nil];
    headerCell = [nibTab objectAtIndex:0];
    [headerCell setHeaderData:menuInfo];
    
    NSArray *loadingNibTab = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
    loadingCell = [loadingNibTab objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger dataNum = [wineList count];
    
    if (dataNum == 0 && isLoading) {
        return 2;
    } else {
        return [wineList count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return headerCell;
    }
    
    if (isLoading) {
        return loadingCell;
    }
    
    static NSString *tableIdentifier = @"MenuWineImagesTableViewCell";
    MenuWineImagesTableViewCell *cell = (MenuWineImagesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:tableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    NSDictionary *wineInfo = (NSDictionary *)[wineList objectAtIndex:indexPath.row - 1];
    [cell setWineData:wineInfo];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [headerCell getRowHeight];
    } else if (isLoading){
        return 50;
    } else {
        return 232;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }

    selectedWineInfo = (NSDictionary *)[wineList objectAtIndex:indexPath.row - 1];
    WineDetailViewController *wineDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"wineDetail"];
    wineDetail.basicInfo = selectedWineInfo;
    [self.navigationController pushViewController:wineDetail animated:YES];
}

- (void) getMenuWines
{
    NSString *url = [NSString stringWithFormat:@"menuinfo/%@", (NSString *)[menuInfo objectForKey:@"menu_id"]];
    
    [AppSetting httpGet:url parameters:NULL callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success)
        {
            NSDictionary *info = (NSDictionary *)[response objectForKey:@"data"];
            wineList = (NSArray *)[info objectForKey:@"menus"];
            isLoading = NO;
            [self.tableView reloadData];
        } else {
            NSLog(@"error");
        }
    }];
}


@end
