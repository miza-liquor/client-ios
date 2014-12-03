//
//  TopStoryTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopStoryTableViewCell.h"

@implementation TopStoryTableViewCell
@synthesize image = _image;
@synthesize title = _title;
@synthesize date = _date;

- (void)awakeFromNib
{
    // Initialization code
    self.image.layer.cornerRadius = 1;
    self.image.layer.masksToBounds = YES;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.y += 1;
    frame.size.height -= 2;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
