//
//  TopWineCategoryViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopWineCategoryViewControllerDelegate

- (void) topWineCategoryChanged: (NSString *) category;

@end

@interface TopWineCategoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <TopWineCategoryViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
