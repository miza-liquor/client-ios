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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickOnDrawerBtn:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
@end
