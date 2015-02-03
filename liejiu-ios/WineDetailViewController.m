//
//  WineDetailViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "WineDetailViewController.h"
#import "WineDetaiHeadTableViewCell.h"
#import "WineCreatorTableViewCell.h"
#import "UserProfileViewController.h"
#import "WineTabBarTableViewCell.h"
#import "WineDrinkUserTableViewCell.h"
#import "MenuListViewController.h"
#import "AppSetting.h"

@interface WineDetailViewController ()

@end

@implementation WineDetailViewController
{
    NSArray *list;
    NSString *tabType;
    WineDetaiHeadTableViewCell *wineHeaderCell;
    WineCreatorTableViewCell *wineCreatorCell;
    WineTabBarTableViewCell *wineTabBar;
    NSDictionary *selectedUserInfo;
}

@synthesize basicInfo;

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
    
    [self initWineBasicHeader];
    tabType = @"drinked";
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

- (void) initWineBasicHeader
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WineDetaiHeadTableViewCell" owner:self options:nil];
    wineHeaderCell = [nib objectAtIndex:0];
//    wineHeaderCell.delegate = self;
    [wineHeaderCell populateWithObject:basicInfo];
    
    NSArray *nibCreator = [[NSBundle mainBundle] loadNibNamed:@"WineCreatorTableViewCell" owner:self options:nil];
    wineCreatorCell = [nibCreator objectAtIndex:0];
    NSDictionary *creatorInfo = (NSDictionary *)[basicInfo objectForKey:@"creator"];
    [wineCreatorCell setCreatorInfo:creatorInfo];
    
    NSArray *nibTab = [[NSBundle mainBundle] loadNibNamed:@"WineTabBarTableViewCell" owner:self options:nil];
    wineTabBar = [nibTab objectAtIndex:0];
    wineTabBar.delegate = self;
    [wineTabBar setData: basicInfo];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    return [list count] + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // header
    if (indexPath.row == 0)
    {
        return wineHeaderCell;
    } else if (indexPath.row == 1) {
        return wineCreatorCell;
    } else if (indexPath.row == 2) {
        return wineTabBar;
    }
    
    static NSString *tableIdentifier = @"WineDrinkUserTableViewCell";
    WineDrinkUserTableViewCell *cell = (WineDrinkUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:tableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.delegate = self;
    [cell setGroupData:[list objectAtIndex:indexPath.row - 3]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        return [[WineDetaiHeadTableViewCell prototypeCell] heightForObject:basicInfo];
    } else if (indexPath.row == 1) {
        return 67;
    } else if (indexPath.row == 2) {
        return 80;
    }

    return 80;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        selectedUserInfo = (NSDictionary *)[basicInfo objectForKey:@"creator"];
        [self performSegueWithIdentifier:@"userDetail" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"userDetail"])
    {
        UserProfileViewController *userProfile = segue.destinationViewController;
        userProfile.fromSubView = YES;
        userProfile.userBasicInfo = selectedUserInfo;
    }
}

- (void) onTagChanged: (NSString *) tabName
{
    tabType = tabName;
    if ([tabType isEqualToString: @"menu"])
    {
        MenuListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"myMenuList"];
        controller.wineInfo = self.basicInfo;
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    [self loadTabContent];
}

- (void) onTagUserImage:(NSDictionary *)userInfo
{
    selectedUserInfo = userInfo;
    [self performSegueWithIdentifier:@"userDetail" sender:self];
}

- (void) loadTabContent
{
    list = nil;
    NSString *wineID = (NSString *)[basicInfo objectForKey:@"id"];
    NSString *cacheName = [NSString stringWithFormat:@"wine-%@-%@", wineID, tabType];
    list = (NSArray *)[AppSetting getCache:cacheName];
    
    if (list != nil || [list count] > 0)
    {
        [self.tableView reloadData];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"wine/%@/%@", tabType, wineID];
    [AppSetting httpGet:url parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            // after check login, go to explore page
            NSArray *data = (NSArray *)[response objectForKey:@"data"];
            int i = 0;
            int step =  6;
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
            list = [NSArray arrayWithArray: renderData];
            [AppSetting setCache:cacheName value: list];
            [self.tableView reloadData];
        } else {
            NSLog(@"error with fetching data");
        }
    }];
}

-(void) selectedMenu:(NSDictionary *)menuInfo
{
    
}

@end
