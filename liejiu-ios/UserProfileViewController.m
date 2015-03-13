//
//  UserProfileViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TGCamera.h"
#import "TGCameraViewController.h"
#import "UserProfileViewController.h"
#import "UserProfileInfoTableViewCell.h"
#import "UserDrinkLikeTableViewCell.h"
#import "UserMenuTableViewCell.h"
#import "FollowListViewController.h"
#import "AppSetting.h"

@interface UserProfileViewController () <TGCameraDelegate>

@end

@implementation UserProfileViewController
{
    NSArray *dataList;
    NSString *tabType;
    NSString *followTypeName;
    UserProfileInfoTableViewCell *headerCell;
    
    BOOL isChangeCover;
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
    isChangeCover = YES;
    
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
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserProfileInfoTableViewCell" owner:self options:nil];
    headerCell = [nib objectAtIndex:0];
    [headerCell setBasicUserInfo: self.userBasicInfo withTab:tabType];
    headerCell.delegate = self;
    
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
        return headerCell;
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

- (void) changeUserCover
{
    isChangeCover = YES;
    [self openCamera];
}

- (void) changeBGCover
{
    isChangeCover = NO;
    [self openCamera];
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

#pragma mark -
#pragma mark - TGCameraDelegate required

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    [self setPhoto:image];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    [self setPhoto:image];
}

- (void) setPhoto:(UIImage *)image
{
    NSString* updateType = isChangeCover ? @"user_cover" : @"user_background";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"正在上传图片" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
    
    
    NSDictionary *params = @{
                             @"type": updateType,
                             @"uploadImages": @[@{
                                                    @"name": @"image",
                                                    @"image": image
                                                    }]
                             };
    [AppSetting httpPost:@"user/update/image" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        
        NSString *updateMsg;
        NSString *updateMsgDetail;
        if (success)
        {
            updateMsg = @"更新成功";
            updateMsgDetail = nil;
            
            if (isChangeCover) {
                [headerCell setUserCover:image];
            } else {
                [headerCell setBGCover:image];
            }
        } else {
            updateMsg = @"更新失败";
            updateMsgDetail = msg;
        }

        [alert setTitle:updateMsg];
        [alert setMessage:updateMsgDetail];
        [alert show];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) openCamera
{
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
}
@end
