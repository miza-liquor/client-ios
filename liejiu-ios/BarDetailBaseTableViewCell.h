//
//  BarDetailBaseTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 12/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@protocol BarDetailBaseTableViewCellDelegate

- (void) gotoMapDetail;

@end

@interface BarDetailBaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *barImage;
@property (weak, nonatomic) IBOutlet UILabel *barName;
@property (weak, nonatomic) IBOutlet UILabel *checkinNum;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *likeUserList;
@property (weak, nonatomic) IBOutlet UIView *infoBg;
@property (weak, nonatomic) IBOutlet UIButton *barLocationImage;
@property (weak, nonatomic) IBOutlet UILabel *barLocation;

- (void) setBarBasicInfo:(NSDictionary *)barBasicInfo;
- (IBAction)clickOnMap:(id)sender;

@property (nonatomic, weak) id <BarDetailBaseTableViewCellDelegate> delegate;

@end
