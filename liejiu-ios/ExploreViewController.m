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
#import "TopImageViewController.h"
#import "MenuDetailViewController.h"
#import "AppSetting.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController
{
    NSArray *topMenus;
    NSString *selectedTopImageUrl;
    NSDictionary *selectedMenuInfo;
    TopImageTableViewCell *topImageCell;
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
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
     v.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:v];
    
    // change navigation bar background
    // fixed ios6, ios7
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:86/255.0 green:51/255.0 blue:195/255.0 alpha:1.0];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
    } else {
        /* Set background and foreground */
    }

    [AppSetting drawToolBar:self];
    [AppSetting topBarStyleSetting:self];
    
    // init data
    topMenus = (NSArray *)[AppSetting getCache:@"topMenu"];
    [self initHeader:(NSArray *) [AppSetting getCache:@"topImage"]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
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

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topMenus count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        selectedMenuInfo = (NSDictionary *)[topMenus objectAtIndex:indexPath.row - 1];
        [self performSegueWithIdentifier:@"menuDetail" sender:self];
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
