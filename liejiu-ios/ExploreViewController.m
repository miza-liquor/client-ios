//
//  ExploreViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "ExploreViewController.h"
#import "TopImageTableViewCell.h"
#import "TopMenuTableViewCell.h"
#import "RecordTableViewCell.h"
#import "LoadingTableViewCell.h"
#import "TopImageViewController.h"
#import "MenuDetailViewController.h"
#import "AppSetting.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController
{
    NSArray *topMenus;
    NSArray *updatesData;
    NSString *selectedTopImageUrl;
    NSDictionary *selectedMenuInfo;
    NSDictionary *selectedUpdateItem;
    TopImageTableViewCell *topImageCell;
    BOOL isUpdateModel;
    BOOL isLoading;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"探索";
    isUpdateModel = NO;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
     v.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:v];

    [AppSetting drawToolBar:self];
    [AppSetting topBarStyleSetting:self];
    
    [self renderTable];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}

- (void) renderTable
{
    if (isUpdateModel) {
        topImageCell = nil;
        topMenus = nil;
        isLoading = YES;
        updatesData = @[];

        [AppSetting httpGet:@"updates" parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            isLoading = NO;

            if (success) {
                updatesData = (NSArray *)[response objectForKey:@"data"];
                [self.tableView reloadData];
            } else {
                NSLog(@"err in fetching updates data");
            }
        }];

    } else {
        topMenus = (NSArray *)[AppSetting getCache:@"topMenu"];
        [self initHeader:(NSArray *) [AppSetting getCache:@"topImage"]];
    }

    [self.tableView reloadData];
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

- (IBAction) clickOnSidebarMenu:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction) clickOnSearchBtn:(id)sender
{
    [self performSegueWithIdentifier:@"search" sender:self];
}

- (IBAction) clickOnSwitcher:(id)sender
{
    UISegmentedControl *seg =  (UISegmentedControl *) sender;

    isUpdateModel = (seg.selectedSegmentIndex == 0) ? NO : YES;
    [self renderTable];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isUpdateModel) {
        return isLoading ? 1 : [updatesData count];
    } else {
        return [topMenus count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // is update model
    if (isUpdateModel) {
        if (isLoading) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
            return [nib objectAtIndex:0];
        } else {
            static NSString *simpleTableIdentifierList = @"RecordTableViewCell";
            RecordTableViewCell *cell = (RecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifierList];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifierList owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            NSDictionary *info = (NSDictionary *)[updatesData objectAtIndex:indexPath.row];
            [cell setRecordData:info];
            return cell;
        }
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
    if (isUpdateModel) {
        return 400;
    } else {
        return indexPath.row == 0 ? 400 : 126;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isUpdateModel) {
        if (!isLoading) {
            selectedUpdateItem = (NSDictionary *)[updatesData objectAtIndex:indexPath.row - 1];
        }
    } else {
        if (indexPath.row != 0)
        {
            selectedMenuInfo = (NSDictionary *)[topMenus objectAtIndex:indexPath.row - 1];
            [self performSegueWithIdentifier:@"menuDetail" sender:self];
        }
    }
}

#pragma mark - Top image cell delegate
- (void) gotoTopBannerDetail: (NSString *) bannerURL
{
    selectedTopImageUrl = bannerURL;
    [self performSegueWithIdentifier:@"topImage" sender:self];
}

- (void) gotoTopSectionList: (NSString *) segueName
{
    [self performSegueWithIdentifier:segueName sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"topImage"])
    {
        TopImageViewController *topImageView = segue.destinationViewController;
        topImageView.url = selectedTopImageUrl;
    }
    else if ([segue.identifier isEqualToString:@"menuDetail"])
    {
        MenuDetailViewController *menuDetail = segue.destinationViewController;
        menuDetail.menuInfo = selectedMenuInfo;
    }
}


@end
