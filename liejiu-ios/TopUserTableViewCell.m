//
//  TopUserTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopUserTableViewCell.h"

@implementation TopUserTableViewCell
@synthesize userImage = _userImage;
@synthesize nickName = _nickName;
@synthesize level = _level;
@synthesize recommand = _recommand;

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
