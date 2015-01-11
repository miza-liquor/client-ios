//
//  MsgChatTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/11/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "MsgChatTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MsgChatTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.height/2;
    self.userImage.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x -= 1;
    
    frame.size.height += 2;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setData: (NSDictionary *)data
{
    NSDictionary *user = (NSDictionary *)[data objectForKey:@"user"];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[user objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"Icon-60.png"]];
    self.nickName.text = (NSString *)[user objectForKey:@"nickname"];
    self.content.text = (NSString *)[data objectForKey:@"content"];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate = [dateFormater dateFromString: (NSString *)[data objectForKey:@"created_at"]];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    self.date.text =[dateFormater stringFromDate:currentDate];
}

@end
