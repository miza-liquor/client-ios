//
//  UserMenuTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserMenuTableViewCell.h"

@implementation UserMenuTableViewCell

@synthesize menuImage = _menuImage;
@synthesize menuName = _menuName;
@synthesize author = _author;
@synthesize wineNum = _wineNum;
@synthesize collectedNum = _collectedNum;

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
