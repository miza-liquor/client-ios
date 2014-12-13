//
//  UserMenuTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserMenuTableViewCell.h"
#import "AppSetting.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UserMenuTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;
    self.menuImage.layer.masksToBounds = YES;
    self.authorImage.layer.cornerRadius = self.authorImage.frame.size.height/2;
    self.authorImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 8;
    frame.origin.y += 3;
    
    frame.size.width -= 16;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (void) setUserMenu:(NSDictionary*)data
{
    NSString *likeNum =[NSString stringWithFormat:@"%@",(NSString *)[data objectForKey:@"like_num"]];
    NSString *wineNum =[NSString stringWithFormat:@"%@",(NSString *)[data objectForKey:@"wine_num"]];
    NSURL *menuImageURL = [NSURL URLWithString:(NSString *)[data objectForKey:@"menu_image"]];
    NSURL *userImageURL = [NSURL URLWithString:(NSString *)[data objectForKey:@"creator_image"]];
    NSDictionary *highLightColor = @{NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1]};

    self.menuName.text = (NSString *)[data objectForKey:@"menu_name"];
    self.author.text = (NSString *)[data objectForKey:@"creator_name"];
    
    self.collectedNum.text = [NSString stringWithFormat:@"收藏数 %@", likeNum];
    [AppSetting settingLabel:self.collectedNum withAttribute:highLightColor inSelectedText:likeNum];
    
    self.wineNum.text = [NSString stringWithFormat:@"酒品数 %@", wineNum];
    [AppSetting settingLabel:self.wineNum withAttribute:highLightColor inSelectedText:wineNum];

    [self.menuImage sd_setImageWithURL:menuImageURL placeholderImage:[UIImage imageNamed:@"Icon-29"]];
    [self.authorImage sd_setImageWithURL:userImageURL placeholderImage:[UIImage imageNamed:@"Icon-29"]];
}

@end
