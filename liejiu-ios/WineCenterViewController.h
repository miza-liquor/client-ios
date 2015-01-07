//
//  WineCenterViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoiding/TPKeyboardAvoidingTableView.h"
#import "WineCenterHeadTableViewCell.h"
#import "WineCenterListTableViewCell.h"
#import "UIViewController+MMDrawerController.h"

@interface WineCenterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, WineCenterListTableViewCellDelegate, WineCenterHeadTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@end
