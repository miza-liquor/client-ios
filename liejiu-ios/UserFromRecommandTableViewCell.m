//
//  UserFromRecommandTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserFromRecommandTableViewCell.h"

@implementation UserFromRecommandTableViewCell
@synthesize userImage = _userImage;
@synthesize nickName = _nickName;
@synthesize level = _level;
@synthesize recordNum = _recordNum;
@synthesize menuNum = _menuNum;

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
