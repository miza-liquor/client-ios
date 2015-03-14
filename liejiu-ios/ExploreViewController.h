//
//  ExploreViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopImageTableViewCell.h"
#import "RecordTableViewCell.h"
#import "MenuListViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface ExploreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, TopImageTableViewCellDelegate, RecordTableViewCellDelegate, MenuListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction) clickOnSidebarMenu:(id)sender;
- (IBAction) clickOnSearchBtn:(id)sender;
- (IBAction) clickOnSwitcher:(id)sender;


@end
