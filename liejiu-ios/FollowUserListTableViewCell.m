//
//  FollowUserListTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "FollowUserListTableViewCell.h"

@implementation FollowUserListTableViewCell

@synthesize userImage = _userImage;
@synthesize nickName = _nickName;
@synthesize relationShip = _relationShip;
@synthesize level = _level;
@synthesize recordNum = _recordNum;

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
