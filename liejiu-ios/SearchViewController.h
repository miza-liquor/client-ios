//
//  SearchViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/27/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchHeaderTableViewCell.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SearchHeaderTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
