//
//  TopWineCategoryTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopWineCategoryTableViewCell.h"

@implementation TopWineCategoryTableViewCell
@synthesize category = _category;
@synthesize bgImage = _bgImage;

- (void)awakeFromNib
{
    // Initialization code
    self.bgImage.layer.cornerRadius = 2;
    self.bgImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 6;
    frame.origin.y += 3;
    
    frame.size.width -= 12;
    frame.size.height -= 6;
    [super setFrame:frame];
}

@end
