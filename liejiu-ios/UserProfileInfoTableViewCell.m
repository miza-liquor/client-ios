//
//  UserProfileInfoTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserProfileInfoTableViewCell.h"

@implementation UserProfileInfoTableViewCell
{
    NSString *followType;
}
@synthesize userImage = _userImage;
@synthesize userName = _userName;
@synthesize followNum = _followNum;
@synthesize likeNum = _likeNum;
@synthesize level = _level;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction) clickOnTab:(id)sender
{
    NSString *tagName = [sender restorationIdentifier];
    [self.delegate onTagChanged:tagName];
}

- (IBAction)clickONFollowInfoBtn:(id)sender
{
    followType = [sender restorationIdentifier];
    [self.delegate onClickFollowBtn:followType];
}

@end
