//
//  AddFriendViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "AddFriendViewController.h"
#import "UserFromContactTableViewCell.h"
#import "UserFromRecommandTableViewCell.h"
#import "UserRecommHeadTableViewCell.h"
#import "UserProfileViewController.h"
#import "AppSetting.h"
#import "LoadingTableViewCell.h"
#import <AddressBook/ABAddressBook.h>

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController
{
    NSMutableArray *users;
    UserRecommHeadTableViewCell *headerCell;
    NSDictionary *selectedUserInfo;
    NSString *searchKeyword;
    BOOL isLoading;
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
    [AppSetting topBarStyleSetting:self];
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:86/255.0 green:51/255.0 blue:195/255.0 alpha:1.0];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
    } else {
        /* Set background and foreground */
    }
    [self initStaticCell];

    users = [[NSMutableArray alloc] init];
    searchKeyword = @"";
    [self getData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void) initStaticCell
{
    NSArray *nibTab = [[NSBundle mainBundle] loadNibNamed:@"UserRecommHeadTableViewCell" owner:self options:nil];
    headerCell = [nibTab objectAtIndex:0];
    headerCell.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return isLoading ? 2 : [users count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return headerCell;
    } else if (isLoading) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
         LoadingTableViewCell *loadingCell = [nib objectAtIndex:0];
        return loadingCell;
    } else {
        static NSString *recommandTableIdentifier = @"UserFromRecommandTableViewCell";
        UserFromRecommandTableViewCell *cell = (UserFromRecommandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:recommandTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:recommandTableIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.delegate = self;
        [cell setUserData:(NSDictionary *)[users objectAtIndex:indexPath.row - 1]];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 60 : 67;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    selectedUserInfo = (NSDictionary *)[users objectAtIndex:indexPath.row - 1];
    UserProfileViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"userProfilePage"];
    controller.userBasicInfo = selectedUserInfo;
    controller.fromSubView = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) searchSwitcherChange:(NSString *)type
{
}

- (void) onFollowBtn:(NSDictionary *)userInfo
{
    NSString *givenUid = (NSString *)[userInfo objectForKey:@"id"];
    for (NSInteger i=0,l=[users count]; i<l; i++) {
        
        NSDictionary *row =[users objectAtIndex:i];
        NSString *uid = (NSString *)[row objectForKey:@"id"];
        if ([uid isEqualToString:givenUid]) {
            [users replaceObjectAtIndex:i withObject:userInfo];
            break;
        }
    }

    [self.tableView reloadData];
}

- (void) submitSearchBox:(NSString *)keywork
{
    searchKeyword = keywork;
    [self getData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"userDetail"])
//    {
//        UserProfileViewController *userProfile = segue.destinationViewController;
//        userProfile.fromSubView = YES;
//        userProfile.userBasicInfo = selectedUserInfo;
//    }
}

- (void) getData
{
    NSString *url = [NSString stringWithFormat:@"search/user/%@", searchKeyword];
    isLoading = YES;
    users = [[NSMutableArray alloc] init];
    [self.tableView reloadData];

    [AppSetting httpGet:url parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        isLoading = NO;
        if (success == YES)
        {
            // after check login, go to explore page
            users = [(NSArray *)[response objectForKey:@"data"] mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

@end
