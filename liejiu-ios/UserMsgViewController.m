//
//  UserMsgViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/10/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "UserMsgViewController.h"
#import "MsgTypeTableViewCell.h"
#import "MsgChatTableViewCell.h"
#import "ChatScreenViewController.h"
#import "AppSetting.h"

@interface UserMsgViewController ()

@end

@implementation UserMsgViewController
{
    NSDictionary *msgData;
    NSDictionary *selectedChatUser;
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
    
    [AppSetting topBarStyleSetting:self];
    UIBarButtonItem *drawerBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_drawer"] style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
    self.navigationItem.leftBarButtonItem = drawerBtn;
    
    [self getMsgData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void) getMsgData
{
    NSString *cacheName = @"userMsgCenterData";
    msgData = [AppSetting getCache:cacheName];
    msgData = (msgData == nil) ? @{
                                   @"comment_num": @"0",
                                   @"update_num": @"0",
                                   @"update_num": @"0",
                                   @"chats": @[]
                                   } : msgData;
    
    [AppSetting httpGet:@"msg/summary" parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            msgData = (NSDictionary *)[response objectForKey:@"data"];
            [AppSetting setCache:cacheName value:msgData];
            [self.tableView reloadData];
        } else {
            NSLog(@"error in fetching msg data");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *list = (NSArray *)[msgData objectForKey:@"chats"];
    return [list count] + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3)
    {
        static NSString *msgTypeIdentifier = @"MsgTypeTableViewCell";
        MsgTypeTableViewCell *typeCell = (MsgTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:msgTypeIdentifier];
        if (typeCell == nil)
        {
            NSArray *collectionNib = [[NSBundle mainBundle] loadNibNamed:msgTypeIdentifier owner:self options:nil];
            typeCell = [collectionNib objectAtIndex:0];
        }
        
        [typeCell setMsgData:msgData inIndex:indexPath.row];
        
        return typeCell;
    } else {
        static NSString *msgListIdentifier = @"MsgChatTableViewCell";
        MsgChatTableViewCell *listCell = (MsgChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:msgListIdentifier];
        if (listCell == nil)
        {
            NSArray *collectionNib = [[NSBundle mainBundle] loadNibNamed:msgListIdentifier owner:self options:nil];
            listCell = [collectionNib objectAtIndex:0];
        }
        NSArray *list = (NSArray *)[msgData objectForKey:@"chats"];
        NSDictionary *info = (NSDictionary *)[list objectAtIndex:indexPath.row - 3];
        [listCell setData:info];
        
//        [listCell setMsgNum:@"0" inIndex:indexPath.row];
        
        return listCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row < 3) ? 60 : 70;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3)
    {
        return;
    }
    NSArray *list = (NSArray *)[msgData objectForKey:@"chats"];
    selectedChatUser = [(NSDictionary *)[list objectAtIndex:indexPath.row - 3] objectForKey:@"user"];
    [self performSegueWithIdentifier:@"chat" sender:self];
}

/*
#pragma mark - Navigation
 */

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"chat"])
    {
        ChatScreenViewController *vc = segue.destinationViewController;
        vc.userInfo = selectedChatUser;
    }
}


#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
