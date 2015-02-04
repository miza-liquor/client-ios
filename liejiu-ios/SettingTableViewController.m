//
//  SettingTableViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AppSetting.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AppSetting topBarStyleSetting:self];
    
    UIColor *color = [UIColor colorWithRed:248.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    self.view.backgroundColor = color;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSString *currVersion = [AppSetting getCurrentVersion];
    NSString *versionInfo = [NSString stringWithFormat:@"检查更新(目前版本 %@)", currVersion];
    self.versionLabel.text = versionInfo;
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    identifier = @"aboutus";
                    break;
                case 1:
                    identifier = @"feedback";
                    break;
                case 2:
                    identifier = @"protocol";
                    break;
                case 3:
                    [self checkVersion];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            break;
    }
    
    if (!identifier)
    {
        return;
    }

    [self performSegueWithIdentifier:identifier sender:self];
}

- (void) checkVersion
{
    self.versionLabel.text = @"正在检查版本";
    [AppSetting httpGet:@"version/ios" parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success)
        {
            NSDictionary *versionInfo = (NSDictionary *)[response objectForKey:@"data"];
            NSString *lastestVersion = (NSString *)[versionInfo objectForKey:@"version"];
            NSString *currVersion = [AppSetting getCurrentVersion];
            UIAlertView *alert;
            
            if ([currVersion isEqualToString:lastestVersion]) {
                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"你的版本已经是最新版本"
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
            } else {
                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:[NSString stringWithFormat:@"请更新到最新版本：%@", lastestVersion]
                                                  delegate:self
                                         cancelButtonTitle:@"下次再更新"
                                         otherButtonTitles:@"更新", nil];
            }
            [alert show];
        } else {
            self.versionLabel.text = @"系统错误，请重试";
        }
    }];
}

- (IBAction)clickOnDrawerBtn:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSURL *url = [NSURL URLWithString:[AppSetting getApiLink:@"download/ios"]];
        
        if (![[UIApplication sharedApplication] openURL:url]) {
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
        }
    }
}
@end
