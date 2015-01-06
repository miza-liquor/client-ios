//
//  TopWineListViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopWineHeaderTableViewCell.h"
#import "TopWineCategoryViewController.h"

@interface TopWineListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TopWineHeaderTableViewCellDelegate, TopWineCategoryViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
