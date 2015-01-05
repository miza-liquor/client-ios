//
//  FollowUserListTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "FollowUserListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FollowUserListTableViewCell

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

- (void) setData:(NSDictionary*)data
{
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    self.nickName.text = (NSString *)[data objectForKey:@"nickname"];
    self.level.text = (NSString *)[data objectForKey:@"level"];
    self.menuNum.text = [[data objectForKey:@"menus"] stringValue];
    self.recordNum.text = @"0";
}

@end
