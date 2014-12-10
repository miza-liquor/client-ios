//
//  DrawerTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 12/10/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "DrawerTableViewCell.h"

@implementation DrawerTableViewCell

@synthesize icon = _icon;
@synthesize labelName = _labelName;
@synthesize notic = _notic;

- (void)awakeFromNib
{
    // Initialization code
    
    self.notic.layer.cornerRadius = self.notic.frame.size.height/2;
    self.notic.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
