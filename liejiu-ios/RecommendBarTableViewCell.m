//
//  RecommendBarTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "RecommendBarTableViewCell.h"

@implementation RecommendBarTableViewCell
@synthesize barImage = _barImage;
@synthesize barName = _barName;
@synthesize checkinNum = _checkinNum;
@synthesize checkinImage1 = _checkinImage1;
@synthesize checkinImage2 = _checkinImage2;
@synthesize checkinImage3 = _checkinImage3;
@synthesize checkinImage4 = _checkinImage4;
@synthesize checkinImage5 = _checkinImage5;
@synthesize checkinImage6 = _checkinImage6;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
