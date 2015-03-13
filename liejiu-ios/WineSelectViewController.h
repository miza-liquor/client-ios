//
//  WineSelectViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 3/13/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WineSelectViewControllerDelegate

- (void) selectedWine: (NSDictionary *)wineInfo;

@end

@interface WineSelectViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, weak) id <WineSelectViewControllerDelegate> delegate;

@end
