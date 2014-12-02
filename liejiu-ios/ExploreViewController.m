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
#import "AppSetting.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController
{
    NSArray *topMenus;
    NSString *selectedTopImageUrl;
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

    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.mm_drawerController setMaximumRightDrawerWidth:180];
    [self.mm_drawerController setMaximumLeftDrawerWidth:240];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
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
    
    //setting navigation bar bg
    UIImage *image = [UIImage imageNamed:@"bg_navbar.png"];
    [image drawInRect:CGRectMake(0, 0, 320, 65)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // bottom bar buttons setting
//    UIImage *imageBtnAdd = [UIImage imageNamed:@"btn_new_record.png"];
//    [self.bottomBtnAdd setBackgroundImage:imageBtnAdd forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIButton *settingsView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 68)];
    [settingsView setBackgroundImage:[UIImage imageNamed:@"btn_new_record"] forState:UIControlStateNormal];
    [self.bottomBtnAdd setCustomView: settingsView];
    
    // init data
    topMenus = (NSArray *)[AppSetting getCache:@"topMenu"];
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
        static NSString *simpleTableIdentifier = @"TopImageTableViewCell";
        TopImageTableViewCell *cell = (TopImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopImageTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [cell setSildeViewImages: (NSArray *) [AppSetting getCache:@"topImage"]];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        return cell;
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
    return indexPath.row == 0 ? 400 : 140;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0)
    {
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
    }
}


@end
