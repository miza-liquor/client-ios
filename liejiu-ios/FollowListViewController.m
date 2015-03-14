//
//  FollowListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/21/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "FollowListViewController.h"
#import "FollowUserListTableViewCell.h"
#import "UserProfileViewController.h"
#import "LoadingTableViewCell.h"
#import "AppSetting.h"

@interface FollowListViewController ()

@end

@implementation FollowListViewController
{
    NSMutableArray *userList;
    NSDictionary *selectedUser;
    BOOL isLoading;
}

@synthesize userID;
@synthesize followType;

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
    
    self.navigationItem.title = [followType isEqualToString:@"following"] ? @"关注" : @"粉丝";
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    return isLoading ? 1 : [userList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
        LoadingTableViewCell *cell = [nib objectAtIndex:0];
        return cell;
    }

    static NSString *simpleTableIdentifier = @"FollowUserListTableViewCell";
    FollowUserListTableViewCell *cell = (FollowUserListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *data = (NSDictionary *)[userList objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell setData:data];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedUser = (NSDictionary *)[userList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"userDetail" sender:self];
}

- (void) getData
{
    userList = [[NSMutableArray alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@/%@", followType, userID];
    isLoading = YES;
    [self.tableView reloadData];

    [AppSetting httpGet:url parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        isLoading = NO;
        if (success == YES)
        {
            userList = [(NSArray *)[response objectForKey:@"data"] mutableCopy];
            [self.tableView reloadData];
        }
    }];
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

- (void) onFollowBtn:(NSDictionary *)userInfo
{
    NSString *givenUid = (NSString *)[userInfo objectForKey:@"id"];
    for (NSInteger i=0,l=[userList count]; i<l; i++) {
        
        NSDictionary *row =[userList objectAtIndex:i];
        NSString *uid = (NSString *)[row objectForKey:@"id"];
        if ([uid isEqualToString:givenUid]) {
            [userList replaceObjectAtIndex:i withObject:userInfo];
            break;
        }
    }
    
    [self.tableView reloadData];
}

@end
