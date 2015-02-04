//
//  DrawerLeftViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "DrawerLeftViewController.h"
#import "AppSetting.h"
#import "DrawerTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DrawerLeftViewController ()

@end

@implementation DrawerLeftViewController
{
    NSArray *drawerMenu;
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
    
    // init drawer data
    drawerMenu = @[
                   @{@"id": @"userProfile", @"icon": @"icon_user_home", @"name": @"个人主页"},
                   @{@"id": @"storyList", @"icon": @"icon_story", @"name": @"日报"},
                   @{@"id": @"myMessage", @"icon": @"icon_msg", @"name": @"消息", @"num": @"12"},
                   @{@"id": @"addFriend", @"icon": @"icon_new_friend", @"name": @"添加好友"}
                ];
    
    self.navigationController.navigationBarHidden = YES;

    UIColor *color = [UIColor colorWithRed:248.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    self.view.backgroundColor = color;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    NSDictionary *userInfo = (NSDictionary *)[AppSetting getCache:@"userInfo"];
    NSString *imageUrl = [userInfo objectForKey:@"cover"];

    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.layer.masksToBounds = YES;

    [self.userImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    self.userNickName.text = [userInfo objectForKey:@"nickname"];
    
    // add bottom button
    UIBarButtonItem *flexibleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonCustomPressed:)];
    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_help"] style:UIBarButtonItemStylePlain target:self action:@selector(helpButtonCustomPressed:)];

    [self.navigationController.toolbar setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];

    self.navigationController.toolbar.clipsToBounds = YES;

    [self setToolbarItems:[NSArray arrayWithObjects:setting, flexibleBtn, help, nil]];
}

- (void)settingButtonCustomPressed:(UIBarButtonItem*)btn
{
    [self openNewCenterView:@"setting"];
}
- (void)helpButtonCustomPressed:(UIBarButtonItem*)btn
{
    [self openNewCenterView:@"help"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [drawerMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifierList = @"DrawerTableViewCell";
    DrawerTableViewCell *cell = (DrawerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifierList];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifierList owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSDictionary *info = (NSDictionary *)[drawerMenu objectAtIndex:indexPath.row];
    cell.icon.image = [UIImage imageNamed:(NSString *)[info objectForKey:@"icon"]];
    cell.labelName.text = (NSString *)[info objectForKey:@"name"];
    NSString *identify = (NSString *)[info objectForKey:@"id"];
    
    if ([identify isEqualToString:@"myMessage"])
    {
        cell.notic.hidden = NO;
        cell.notic.text = (NSString *)[info objectForKey:@"num"];
    } else {
        cell.notic.hidden = YES;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = (NSDictionary *)[drawerMenu objectAtIndex:indexPath.row];
    NSString *identifier = (NSString *)[info objectForKey:@"id"];
    UIViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:identifier];

    [self.mm_drawerController setCenterViewController:vc withFullCloseAnimation:YES completion:nil];
}

- (void) openNewCenterView:(NSString *)identifier
{
    UIViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.mm_drawerController setCenterViewController:vc withFullCloseAnimation:YES completion:nil];
}

@end
