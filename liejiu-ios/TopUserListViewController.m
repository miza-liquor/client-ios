//
//  TopUserListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopUserListViewController.h"
#import "TopUserTableViewCell.h"
#import "UserProfileViewController.h"
#import "LoadingTableViewCell.h"
#import "AppSetting.h"

@interface TopUserListViewController ()

@end

@implementation TopUserListViewController
{
    NSDictionary *userList;
    NSArray *userListSectionTitle;
    NSDictionary *selectedUser;
    
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
    
    isLoading = YES;
    // fetch top user data from cache or server
    [AppSetting drawToolBar:self];
    [self getData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return isLoading ? 1 : [userListSectionTitle count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    return [userGroupTitles objectAtIndex:section];
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(10, 12, tableView.frame.size.width, 28);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont boldSystemFontOfSize:16]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:(NSString *)[userListSectionTitle objectAtIndex:section]];
    NSString *bgName = (section == 0) ? @"bg_top_user_week" :@"bg_top_user_all";
    UIImage *image = [UIImage imageNamed:bgName];
    UIImageView *bg = [[UIImageView alloc] initWithImage:image];
    [bg setFrame:CGRectMake(0, 12, image.size.width, 28)];
    [view addSubview:bg];
    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isLoading) return 1;
    // Return the number of rows in the section.
    NSString *sectionTitle = [userListSectionTitle objectAtIndex:section];
    NSArray *sectionAnimals = [userList objectForKey:sectionTitle];
    return [sectionAnimals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
        LoadingTableViewCell *loadingCell = [nib objectAtIndex:0];
        return loadingCell;
    }
    
    static NSString *simpleTableIdentifier = @"TopUserTableViewCell";
    TopUserTableViewCell *cell = (TopUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];

    }
    cell.delegate = self;
    NSString *sectionTitle = [userListSectionTitle objectAtIndex:indexPath.section];
    NSArray *rows = [userList objectForKey:sectionTitle];
    NSDictionary *userInfo = (NSDictionary *)[rows objectAtIndex:indexPath.row];
    [cell setUserData:userInfo];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) return;
    NSString *sectionTitle = [userListSectionTitle objectAtIndex:indexPath.section];
    NSArray *rows = [userList objectForKey:sectionTitle];
    selectedUser = (NSDictionary *)[rows objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"userDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"userDetail"])
    {
        UserProfileViewController *userProfile = segue.destinationViewController;
        userProfile.fromSubView = YES;
        userProfile.userBasicInfo = selectedUser;
    }
}

- (void) followUser: (NSString *) userID
{
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void) getData
{
    NSString *cacheName = @"topuser";
    NSDictionary *cache = (NSDictionary *)[AppSetting getCache:cacheName];
    isLoading = YES;

    if (cache == Nil)
    {
        [AppSetting httpGet:cacheName parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            isLoading = NO;
            if (success == YES)
            {
                userList = (NSDictionary *)[response objectForKey:@"data"];
                [AppSetting setCache:cacheName value:userList];
                userListSectionTitle = [userList allKeys];
                [self.tableView reloadData];
            }
        }];
    } else {
        isLoading = NO;
        userList = cache;
        userListSectionTitle = [userList allKeys];
    }
}

@end
