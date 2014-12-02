//
//  SettingTableViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "SettingTableViewController.h"

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    UIViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        if ([self.mm_drawerController.centerViewController.restorationIdentifier isEqualToString:vc.restorationIdentifier])
        {
            return;
        }
        
        self.mm_drawerController.centerViewController = vc;
    }];
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

@end
