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

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController
{
    NSDictionary *userProfile;
    NSArray *dataList;
    NSString *tabType;
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
    
    userProfile = @{
                    @"nickName": @"zhangge",
                    @"relationShip":@"1",
                    @"followNum": @"22",
                    @"followerNum": @"444",
                    @"likeNum": @"111",
                    @"level": @"2332"
                };
    dataList = @[@"1",@"2",@"3",@"4",@"5"];
    tabType = @"drinked";
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
        }

        cell.delegate = self;
        return cell;
    } else {
        if ([tabType isEqualToString:@"menu"])
        {
            static NSString *menuTableIdentifier = @"UserMenuTableViewCell";
            UserProfileInfoTableViewCell *menuCell = (UserProfileInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:menuTableIdentifier];
            if (menuCell == nil)
            {
                NSArray *menuNib = [[NSBundle mainBundle] loadNibNamed:menuTableIdentifier owner:self options:nil];
                menuCell = [menuNib objectAtIndex:0];
            }

            return menuCell;
        } else {
            static NSString *collectionTableIdentifier = @"UserDrinkLikeTableViewCell";
            UserProfileInfoTableViewCell *collectionCell = (UserProfileInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:collectionTableIdentifier];
            if (collectionCell == nil)
            {
                NSArray *collectionNib = [[NSBundle mainBundle] loadNibNamed:collectionTableIdentifier owner:self options:nil];
                collectionCell = [collectionNib objectAtIndex:0];
            }

            return collectionCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 220;
    } else {
        if ([tabType isEqualToString:@"menu"])
        {
            return 84;
        } else {
            return 100;
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tabType isEqualToString:@"menu"])
    {
        [self performSegueWithIdentifier:@"menuDetail" sender:self];
    }
//    [self performSegueWithIdentifier:@"storyDetail" sender:self];
}

#pragma mark - user profile header delegate
- (void) onTagChanged:(NSString *)tabName
{
    tabType = tabName;
    [self.tableView reloadData];
}

- (void) onClickFollowBtn:(NSString *)followType
{
    [self performSegueWithIdentifier:@"follow" sender:self];
}

@end
