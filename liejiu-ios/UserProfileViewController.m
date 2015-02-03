//
//  UserProfileViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileInfoTableViewCell.h"
#import "UserDrinkLikeTableViewCell.h"
#import "UserMenuTableViewCell.h"
#import "FollowListViewController.h"
#import "AppSetting.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController
{
    NSArray *dataList;
    NSString *tabType;
    NSString *followTypeName;
}
@synthesize fromSubView;
@synthesize userBasicInfo;

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

    dataList = @[];
    tabType = @"drinked";
    
    // check if open from drawer
    if (!fromSubView)
    {
        UIBarButtonItem *drawerBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_drawer"] style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
        self.navigationItem.leftBarButtonItem = drawerBtn;
        
        // from drawer, is owner
        self.userBasicInfo = (NSDictionary *)[AppSetting getCache:@"userInfo"];
    }

    self.automaticallyAdjustsScrollViewInsets = NO;
    [AppSetting drawToolBar:self];
    [AppSetting topBarStyleSetting:self];
    
    // load tab data
    [self loadTabContent];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *simpleTableIdentifier = @"UserProfileInfoTableViewCell";
        UserProfileInfoTableViewCell *cell = (UserProfileInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];

            [cell setBasicUserInfo: self.userBasicInfo withTab:tabType];
        }

        cell.delegate = self;
        return cell;
    } else {
        if ([tabType isEqualToString:@"mymenu"])
        {
            static NSString *menuTableIdentifier = @"UserMenuTableViewCell";
            UserMenuTableViewCell *menuCell = (UserMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:menuTableIdentifier];
            if (menuCell == nil)
            {
                NSArray *menuNib = [[NSBundle mainBundle] loadNibNamed:menuTableIdentifier owner:self options:nil];
                menuCell = [menuNib objectAtIndex:0];
            }

            [menuCell setUserMenu:[dataList objectAtIndex:indexPath.row - 1]];
            return menuCell;
        } else {
            static NSString *collectionTableIdentifier = @"UserDrinkLikeTableViewCell";
            UserDrinkLikeTableViewCell *collectionCell = (UserDrinkLikeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:collectionTableIdentifier];
            if (collectionCell == nil)
            {
                NSArray *collectionNib = [[NSBundle mainBundle] loadNibNamed:collectionTableIdentifier owner:self options:nil];
                collectionCell = [collectionNib objectAtIndex:0];
            }

            [collectionCell setGroupData:[dataList objectAtIndex:indexPath.row - 1]];
            return collectionCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 300;
    } else {
        return 77;
//        
//        if ([tabType isEqualToString:@"mymenu"])
//        {
//            return 80;
//        } else {
//            return 77;
//        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tabType isEqualToString:@"mymenu"])
    {
        [self performSegueWithIdentifier:@"menuDetail" sender:self];
    }
//    [self performSegueWithIdentifier:@"storyDetail" sender:self];
}

- (void) loadTabContent
{
    NSString *userID = (NSString *)[self.userBasicInfo objectForKey:@"id"];
    NSString *cacheName = [NSString stringWithFormat:@"user-%@-%@", userID, tabType];
    dataList = (NSArray *)[AppSetting getCache:cacheName];
    NSString *url = [NSString stringWithFormat:@"%@/%@", tabType, userID];
    
    if (dataList != nil || [dataList count] > 0)
    {
        [self.tableView reloadData];
        return;
    }
    
    [AppSetting httpGet:url parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            // after check login, go to explore page
            NSArray *data = (NSArray *)[response objectForKey:@"data"];
            if ([tabType isEqualToString:@"mymenu"])
            {
                dataList = data;
                [AppSetting setCache:cacheName value: dataList];
                [self.tableView reloadData];
                return;
            }
            int i = 0;
            int step =  4;
            int groupIdx = -1;
            NSMutableArray *renderData = [[NSMutableArray alloc] initWithCapacity:(int)ceilf([data count]/step)];
            
            for (NSArray *wine in data) {
                NSMutableArray *groupData;
                if (i % step == 0)
                {
                    groupData = [[NSMutableArray alloc] initWithCapacity:step];
                    [renderData addObject:groupData];
                    groupIdx++;
                }
                [(NSMutableArray *)[renderData objectAtIndex:groupIdx] addObject:wine];
                i++;
            }
            dataList = [NSArray arrayWithArray: renderData];
            [AppSetting setCache:cacheName value: dataList];
            [self.tableView reloadData];
        } else {
            NSLog(@"error with fetching data");
        }
    }];
}

#pragma mark - user profile header delegate
- (void) onTagChanged:(NSString *)tabName
{
    tabType = tabName;
    [self loadTabContent];
}

- (void) onClickFollowBtn:(NSString *)followType
{
    followTypeName = followType;
    [self performSegueWithIdentifier:@"follow" sender:self];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"follow"])
    {
        FollowListViewController *vc = segue.destinationViewController;
        vc.followType = followTypeName;
        vc.userID = (NSString *)[self.userBasicInfo objectForKey:@"id"];
    }
}


@end
