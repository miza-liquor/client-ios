//
//  MenuDetailViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSDictionary *menuInfo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
