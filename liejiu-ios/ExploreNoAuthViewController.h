//
//  ExploreNoAuthViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopImageTableViewCell.h"

@interface ExploreNoAuthViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, TopImageTableViewCellDelegate>

- (IBAction)login:(id)sender;

@end
