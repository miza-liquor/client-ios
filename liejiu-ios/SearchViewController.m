//
//  SearchViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/27/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHeaderTableViewCell.h"
#import "UserFromRecommandTableViewCell.h"
#import "TopMenuTableViewCell.h"
#import "LoadingTableViewCell.h"
#import "RecordCellTableViewCell.h"
#import "AppSetting.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    SearchHeaderTableViewCell *headerCell;
    LoadingTableViewCell *loadingCell;
    NSString *keyword;
    NSString* searchTabName;
    NSArray *dataList;
    BOOL isLoading;
    CGFloat contentRowHeight;
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
    isLoading = true;
    [AppSetting drawToolBar:self];
    [self initStaticCell];
    [self loadWineData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void) loadWineData
{

    NSString *currentTab = searchTabName;
    NSString *url = [NSString stringWithFormat:@"search/%@/%@", searchTabName, keyword];
    dataList = @[];
    isLoading = YES;
    [self.tableView reloadData];
    
    if ([searchTabName isEqualToString:@"user"]) {
        contentRowHeight = 74;
    } else if ([searchTabName isEqualToString:@"record"]) {
        contentRowHeight = 80;
    } else {
        contentRowHeight = 126;
    }
    [AppSetting httpGet:url parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success && [currentTab isEqualToString:searchTabName]) {
            dataList = (NSArray *)[response objectForKey:@"data"];
            isLoading = NO;
            [self.tableView reloadData];
        } else {
            NSLog(@"error in fetching data");
        }
    }];
    
    
}

- (void) initStaticCell
{
    NSArray *nibTab = [[NSBundle mainBundle] loadNibNamed:@"SearchHeaderTableViewCell" owner:self options:nil];
    headerCell = [nibTab objectAtIndex:0];
    headerCell.delegate = self;
    keyword = @"";
    searchTabName = [headerCell getTabIndex];
    
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
    NSUInteger dataNum = [dataList count];
    
    if (dataNum == 0 && isLoading) {
        return 2;
    } else {
        return [dataList count] + 1;
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

    static NSString *simpleTableIdentifier;
    NSDictionary* dataInfo = (NSDictionary *)[dataList objectAtIndex:indexPath.row - 1];
    if ([searchTabName isEqualToString:@"user"]) {
        simpleTableIdentifier = @"UserFromRecommandTableViewCell";
        UserFromRecommandTableViewCell *cell = (UserFromRecommandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        [cell setUserData:dataInfo];
        return cell;
    } else if ([searchTabName isEqualToString:@"menu"]) {
        simpleTableIdentifier = @"TopMenuTableViewCell";
        TopMenuTableViewCell *cell = (TopMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setTopMenuData:dataInfo];
        return cell;
    } else {
        simpleTableIdentifier = @"RecordCellTableViewCell";
        RecordCellTableViewCell *cell = (RecordCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        [cell setRecordData:dataInfo];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 100;
    } else if (isLoading){
        return 50;
    } else {
        return contentRowHeight;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
//    selectedWine = (NSDictionary *)[wineList objectAtIndex:indexPath.row-1];
//    [self performSegueWithIdentifier:@"wineDetail" sender:self];
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

- (void) onTabChanged:(NSString *)tabName
{
    searchTabName = tabName;
    [self loadWineData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
