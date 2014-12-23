//
//  BarDetailBaseTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 12/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface BarDetailBaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *barImage;
@property (weak, nonatomic) IBOutlet UILabel *barName;
@property (weak, nonatomic) IBOutlet UILabel *barLocation;
@property (weak, nonatomic) IBOutlet UILabel *checkinNum;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *likeUserList;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIView *infoBg;

- (void) setBarBasicInfo:(NSDictionary *)barBasicInfo;

@end
