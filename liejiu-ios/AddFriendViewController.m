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
#import <AddressBook/ABAddressBook.h>

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController
{
    NSArray *users;
    UserRecommHeadTableViewCell *headerCell;
    NSDictionary *selectedUserInfo;
    NSString *searchKeyword;
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

    users = @[];
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
    return [users count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return headerCell;
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
    
    [AppSetting httpGet:url parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            // after check login, go to explore page
            users = (NSArray *)[response objectForKey:@"data"];
            [self.tableView reloadData];
        }
    }];
}

@end
