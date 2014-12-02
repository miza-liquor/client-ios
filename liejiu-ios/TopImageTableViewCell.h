//
//  TopImageTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/17/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopImageTableViewCellDelegate

- (void) gotoTopBannerDetail: (NSString *) bannerURL;
- (void) gotoTopSectionList: (NSString *) segueName;

@end

@interface TopImageTableViewCell : UITableViewCell

- (void) setSildeViewImages:(NSArray *)images;
- (IBAction) clickOnTopSectionBtn:(id)sender;
@property (nonatomic, weak) id <TopImageTableViewCellDelegate> delegate;

@end