//
//  WineCenterHeadTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/7/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WineCenterHeadTableViewCellDelegate

- (void) submitSearchBox: (NSString *) keywork;
- (void) clickOnCategoryBtn: (NSDictionary *) category;
- (void) categoryDataReady;

@end

@interface WineCenterHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *searchBox;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)clickOnSearchBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *categoryContainer;
@property (nonatomic, weak) id <WineCenterHeadTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

- (CGFloat) getRowHeight;

@end
