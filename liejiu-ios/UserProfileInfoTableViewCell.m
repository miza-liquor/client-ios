//
//  UserProfileInfoTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserProfileInfoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

@implementation UserProfileInfoTableViewCell
{
    NSString *followType;
    NSArray *tabList;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.tabDrinked.layer.cornerRadius = 2;
    self.tabDrinking.layer.cornerRadius = 2;
    self.tabCollection.layer.cornerRadius = 2;
    self.tabDrinked.layer.cornerRadius = 2;
    self.tapMenu.layer.cornerRadius = 2;
    self.btnUserImage.layer.cornerRadius = self.btnUserImage.frame.size.height/2;
    self.btnUserImage.layer.masksToBounds = YES;
    
    [self updateTabBtnState:@"drinked"];
    
    tabList = @[self.tabDrinked, self.tabDrinking, self.tapMenu, self.tabCollection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction) clickOnTab:(id)sender
{
    NSString *tagName = [sender restorationIdentifier];
    [self updateTabBtnState:tagName];
    [self.delegate onTagChanged:tagName];
}

- (IBAction)clickONFollowInfoBtn:(id)sender
{
    followType = [sender restorationIdentifier];
    [self.delegate onClickFollowBtn:followType];
}

- (void) setBasicUserInfo:(NSDictionary *)userBasicInfo withTab:(NSString *)tabName
{
    [self updateTabBtnState:tabName];
    self.userName.text = (NSString *)[userBasicInfo objectForKey:@"nickname"];
    [self.followerNum setTitle:[NSString stringWithFormat:@" 粉丝(%@)", (NSString *)[userBasicInfo objectForKey:@"followers"]] forState:UIControlStateNormal];
    [self.followNum setTitle:[NSString stringWithFormat:@" 关注(%@)", (NSString *)[userBasicInfo objectForKey:@"following"]] forState:UIControlStateNormal];
    [self.likeNum setTitle:[NSString stringWithFormat:@" 赞(%@)", (NSString *)[userBasicInfo objectForKey:@"likes"]] forState:UIControlStateNormal];

    [self.btnUserImage sd_setBackgroundImageWithURL:[NSURL URLWithString:(NSString *)[userBasicInfo objectForKey:@"cover"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon.png"]];
}

- (void) updateTabBtnState:(NSString *)tabName
{
    for (UIButton *tab in tabList) {
        if ([tabName isEqualToString:(NSString *)[tab restorationIdentifier]])
        {
            [tab setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:117.0/255.0 blue:214.0/255.0 alpha:1]];
        } else {
            [tab setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:153.0/255.0 blue:223.0/255.0 alpha:1]];
        }
    }
}

@end
