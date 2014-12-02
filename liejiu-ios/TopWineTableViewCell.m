//
//  TopWineTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopWineTableViewCell.h"

@implementation TopWineTableViewCell
@synthesize image = _image;
@synthesize category = _category;
@synthesize score = _score;
@synthesize name = _name;
@synthesize drinked = _drinked;

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
