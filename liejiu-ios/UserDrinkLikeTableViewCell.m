//
//  UserDrinkLikeTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserDrinkLikeTableViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation UserDrinkLikeTableViewCell
{
    NSArray *wineList;
}

- (void)awakeFromNib
{
    // Initialization code
    wineList = [[NSArray alloc] initWithObjects:self.wine1, self.wine2, self.wine3, self.wine4, nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setGroupData:(NSArray *)data
{
    int currNum = (int)[data count];
    int totalPlace = (int)[wineList count];
    
    for (int i = 0; i < totalPlace; i++)
    {
        UIButton *btn = (UIButton *)[wineList objectAtIndex:i];
        if (i < currNum)
        {
            NSURL *imageURL = [NSURL URLWithString:(NSString *)[(NSDictionary *)[data objectAtIndex:i] objectForKey:@"wine_image"]];

            [btn sd_setBackgroundImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Icon-29"]];
            [btn setHidden:NO];
        } else {
            [btn setHidden:YES];
        }
    }
}

@end
