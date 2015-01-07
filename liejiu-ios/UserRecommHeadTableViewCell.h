//
//  UserRecommHeadTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/7/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserRecommHeadTableViewCellDelegate

- (void) searchSwitcherChange: (NSString *) type;
- (void) submitSearchBox: (NSString *) keywork;

@end

@interface UserRecommHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *searchBox;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switcher;
- (IBAction)clickOnSearchBtn:(id)sender;

@property (nonatomic, weak) id <UserRecommHeadTableViewCellDelegate> delegate;

@end
