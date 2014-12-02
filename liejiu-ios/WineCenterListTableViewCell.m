//
//  WineCenterListTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "WineCenterListTableViewCell.h"

@implementation WineCenterListTableViewCell
@synthesize wineImage = _wineImage;
@synthesize category = _category;
@synthesize wineName = _wineName;
@synthesize drinkedNum = _drinkedNum;
@synthesize userImage1 = _userImage1;
@synthesize userImage2 = _userImage2;
@synthesize userImage3 = _userImage3;
@synthesize userImage4 = _userImage4;
@synthesize userImage5 = _userImage5;
@synthesize userImage6 = _userImage6;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction) clickOnMenuBtn:(id)sender
{
    [self.delegate addWineToMenuList:@"1"];
}

@end
