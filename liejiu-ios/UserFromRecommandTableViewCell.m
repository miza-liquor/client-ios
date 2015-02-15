//
//  UserFromRecommandTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserFromRecommandTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"


@implementation UserFromRecommandTableViewCell
{
    NSMutableDictionary *userInfo;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.height/2;
    self.userImage.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.origin.y += 3;
    
    frame.size.width -= 20;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setUserData:(NSDictionary *)info
{
    userInfo = [info mutableCopy];

    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[info objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"Icon-60.png"]];
    
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

    NSString *levelNum = [NSString stringWithFormat:@"%@", (NSString *)[info objectForKey:@"level"]];
    NSString *menusNum = [NSString stringWithFormat:@"%@", [[info objectForKey:@"menus"] stringValue]];
    NSString *recordsNum = [NSString stringWithFormat:@"%@", [[info objectForKey:@"wines"] stringValue]];
    
    NSDictionary *highLightColor = @{NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1]};
    
    self.level.text = [NSString stringWithFormat:@"级别:%@", levelNum];
    self.recordNum.text = [NSString stringWithFormat:@"记录数:%@", recordsNum];
    self.menuNum.text = [NSString stringWithFormat:@"酒单:%@", menusNum];
    self.nickName.text = (NSString *)[info objectForKey:@"nickname"];
    
    
    [AppSetting settingLabel:self.level withAttribute:highLightColor inSelectedText:levelNum];
    [AppSetting settingLabel:self.recordNum withAttribute:highLightColor inSelectedText:recordsNum];
    [AppSetting settingLabel:self.menuNum withAttribute:highLightColor inSelectedText:menusNum];
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
            [self.delegate onFollowBtn: userInfo];
            [self setUserData:userInfo];
        } else {
            [self setUserData:userInfo];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
@end
