//
//  RecommendBarTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendBarTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *barImage;
@property (strong, nonatomic) IBOutlet UILabel *barName;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *checkinNum;
@property (strong, nonatomic) IBOutlet UIImageView *checkinImage1;
@property (strong, nonatomic) IBOutlet UIImageView *checkinImage2;
@property (strong, nonatomic) IBOutlet UIImageView *checkinImage3;
@property (strong, nonatomic) IBOutlet UIImageView *checkinImage4;
@property (strong, nonatomic) IBOutlet UIImageView *checkinImage5;
@property (strong, nonatomic) IBOutlet UIImageView *checkinImage6;

- (void) setTopBarData:(NSDictionary *)data;

@end
