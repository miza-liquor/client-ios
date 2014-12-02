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
#import <AddressBook/ABAddressBook.h>

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController
{
    NSDictionary *users;
    NSArray *userGroupTitles;
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
    
    UIBarButtonItem *drawerBtn = [[UIBarButtonItem alloc] initWithTitle:@"抽屉" style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
    self.navigationItem.leftBarButtonItem = drawerBtn;
    
    users = @{
                 @"推荐用户": @[
                         @{@"nickName": @"用户1", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户2", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户3", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户4", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户5", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户6", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户7", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户8", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户9", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户10", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户11", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"},
                         @{@"nickName": @"用户12", @"level": @"12", @"recordNum": @"222", @"menuNum": @"12"}
                         ],
                 @"通讯录好友": @[
                         @{@"name": @"通讯录1", @"phone": @"1234567"},
                         @{@"name": @"通讯录2", @"phone": @"1234567"},
                         @{@"name": @"通讯录3", @"phone": @"1234567"},
                         @{@"name": @"通讯录4", @"phone": @"1234567"},
                         @{@"name": @"通讯录5", @"phone": @"1234567"},
                         @{@"name": @"通讯录6", @"phone": @"1234567"},
                         @{@"name": @"通讯录7", @"phone": @"1234567"},
                         @{@"name": @"通讯录8", @"phone": @"1234567"},
                         @{@"name": @"通讯录9", @"phone": @"1234567"},
                         @{@"name": @"通讯录10", @"phone": @"1234567"}
                         ]
                };
    userGroupTitles = @[@"推荐用户", @"通讯录好友"];
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"Denied");
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        //3
        NSLog(@"Not determined");
    }
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

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [userGroupTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [userGroupTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [userGroupTitles objectAtIndex:section];
    NSArray *sectionAnimals = [users objectForKey:sectionTitle];
    return [sectionAnimals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionTitle = [userGroupTitles objectAtIndex:indexPath.section];
    NSArray *sectionUserList = [users objectForKey:sectionTitle];
    NSDictionary *userInfo = (NSDictionary *)[sectionUserList objectAtIndex:indexPath.row];

    if (indexPath.section == 0)
    {
        static NSString *recomTableIdentifier = @"UserFromRecommandTableViewCell";
        UserFromRecommandTableViewCell *cellRecom = (UserFromRecommandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:recomTableIdentifier];
        if (cellRecom == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:recomTableIdentifier owner:self options:nil];
            cellRecom = [nib objectAtIndex:0];
        }

        cellRecom.nickName.text = [userInfo objectForKey:@"nickName"];
        cellRecom.level.text = [userInfo objectForKey:@"level"];
        cellRecom.recordNum.text = [NSString stringWithFormat:@"记录(%@)", [userInfo objectForKey:@"recordNum"]];
        cellRecom.menuNum.text = [NSString stringWithFormat:@"酒单(%@)", [userInfo objectForKey:@"menuNum"]];
        
        return cellRecom;
    } else {
        static NSString *contactTableIdentifier = @"UserFromContactTableViewCell";
        UserFromContactTableViewCell *cell = (UserFromContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:contactTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:contactTableIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.userName.text = [userInfo objectForKey:@"name"];
        cell.phone.text = [userInfo objectForKey:@"phone"];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 100 : 50;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
