//
//  TopUserTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopUserTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"

@implementation TopUserTableViewCell
{
    NSMutableDictionary *userInfo;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;
    
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width/2;
    self.userImage.layer.masksToBounds = YES;
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

- (IBAction)clickOnFollowBtn:(id)sender
{
    
    NSDictionary *params = @{@"userid": (NSString *)[userInfo objectForKey:@"id"]};
    [self.followBtn setTitle:@"加载中" forState:UIControlStateNormal];
    
    [AppSetting httpPost:@"update/relation" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success)
        {
            NSDictionary *updateUserInfo = (NSDictionary *)[response objectForKey:@"data"];
            BOOL beFollowed = (BOOL)[[updateUserInfo objectForKey:@"be_followed"] boolValue];
            BOOL beFollower = (BOOL)[[updateUserInfo objectForKey:@"be_follower"] boolValue];
            [userInfo setValue:[NSNumber numberWithBool:beFollowed] forKey:@"be_followed"];
            [userInfo setValue:[NSNumber numberWithBool:beFollower] forKey:@"be_follower"];
            [self setUserData:userInfo];
            [self.delegate followUser: userInfo];
            [self setUserData:userInfo];
        } else {
            [self setUserData:userInfo];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void) setUserData:(NSMutableDictionary *)data
{
    userInfo = data;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    
    BOOL beFollowed = (BOOL)[[userInfo objectForKey:@"be_followed"] boolValue];
    BOOL beFollower = (BOOL)[[userInfo objectForKey:@"be_follower"] boolValue];
    NSString *followTitle;
    
    if (beFollowed && beFollower)
    {
        followTitle = @"×相互关注";
    } else if (beFollower)
    {
        followTitle = @"  × 已关注";
    } else {
        followTitle = @"  + 加关注";
    }

    [self.followBtn setTitle:followTitle forState:UIControlStateNormal];
    self.nickName.text = (NSString *)[data objectForKey:@"nickname"];
    self.level.text = (NSString *)[data objectForKey:@"level"];
    self.recommand.text = [NSString stringWithFormat:@"推荐理由：%@", (NSString *)[data objectForKey:@"reasons"]];
}

@end
