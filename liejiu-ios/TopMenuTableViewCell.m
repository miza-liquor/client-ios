//
//  TopMenuTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopMenuTableViewCell.h"
#import "AppSetting.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TopMenuTableViewCell
{
    NSMutableArray *menuList;
}


- (void)awakeFromNib
{
    // Initialization code
    self.userImage.layer.cornerRadius = 25;
    self.userImage.layer.masksToBounds = YES;
    
    menuList = [[NSMutableArray alloc] initWithObjects:self.wineImage1, self.wineImage2, self.wineImage3, self.wineImage4, self.wineImage5, nil];

    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 6;
    frame.origin.y += 3;

    frame.size.width -= 12;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTopMenuData:(NSDictionary *)data
{
    NSString *userNameText =(NSString *)[data objectForKey:@"creator_name"];
    self.userName.text = [NSString stringWithFormat:@"%@ 的酒单", userNameText];
    self.menuName.text = (NSString *)[data objectForKey:@"menu_name"];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"creator_image"]] placeholderImage:[UIImage imageNamed:@"Icon-60.png"]];
    self.likeNum.text = [NSString stringWithFormat:@"%d", [[data objectForKey:@"like_num"] intValue]];
    int liked = [[data objectForKey:@"liked"] intValue];
    NSString *likeImageName = liked == 0 ? @"icon_like" : @"icon_liked";
    self.likeImage.image = [UIImage imageNamed:likeImageName];

    [AppSetting settingLabel:self.userName withAttribute:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.userName.font.pointSize]} inSelectedText:userNameText];

    
    NSArray *menus = (NSArray *)[data objectForKey:@"menus"];
    int totalNum = (int)[menuList count];
    int currNum = (int)[menus count];
    
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
