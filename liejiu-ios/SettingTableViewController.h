//
//  SettingTableViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"

@interface SettingTableViewController : UITableViewController<UIAlertViewDelegate>
- (IBAction)clickOnDrawerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end
