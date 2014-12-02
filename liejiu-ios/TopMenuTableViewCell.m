//
//  TopMenuTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopMenuTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TopMenuTableViewCell
{
    NSMutableArray *menuList;
}


- (void)awakeFromNib
{
    // Initialization code
    self.userImage.layer.cornerRadius = 21;
    self.userImage.layer.masksToBounds = YES;
    
    menuList = [[NSMutableArray alloc] initWithObjects:self.wineImage1, self.wineImage2, self.wineImage3, self.wineImage4, nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTopMenuData:(NSDictionary *)data
{
    self.userName.text = [NSString stringWithFormat:@"%@ 的酒单", (NSString *)[data objectForKey:@"creator_name"]];
    self.menuName.text = (NSString *)[data objectForKey:@"menu_name"];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"creator_image"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    NSArray *menus = (NSArray *)[data objectForKey:@"menus"];
    int totalNum = [menuList count];
    int currNum = [menus count];
    
    for (int i = 0; i < totalNum; i++) {
        UIImageView *menuImage = (UIImageView *)[menuList objectAtIndex:i];
        if (i < currNum)
        {
            [menuImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[menus objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
            [menuImage setHidden:NO];
        } else {
            [menuImage setHidden:YES];
        }
    }
}

@end
