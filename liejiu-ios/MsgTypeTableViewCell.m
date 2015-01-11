//
//  MsgTypeTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/11/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "MsgTypeTableViewCell.h"

@implementation MsgTypeTableViewCell
{
    NSArray *config;
}

- (void)awakeFromNib
{
    // Initialization code
    self.msgNum.layer.cornerRadius = self.msgNum.layer.frame.size.height/2;
    self.msgNum.layer.masksToBounds = YES;
    
    
    config = @[
                        @{
                            @"color": [UIColor colorWithRed:69.0/255.0 green:153.0/255.0 blue:223.0/255.0 alpha:1],
                            @"icon": @"Icon_comment",
                            @"data_key": @"comment_num"
                        },
                        @{
                            @"color": [UIColor colorWithRed:133.0/255.0 green:89.0/255.0 blue:227.0/255.0 alpha:1],
                            @"icon": @"Icon_update",
                            @"data_key": @"update_num"
                        },
                        @{
                            @"color": [UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1],
                            @"icon": @"Icon_love_list",
                            @"data_key": @"like_num"
                        }
                    ];
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.y += 4;
    
    frame.size.height -= 4;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMsgData:(NSDictionary *)data inIndex:(NSInteger)index
{
    NSDictionary *info = [config objectAtIndex:index];
    [self setBackgroundColor: [info objectForKey:@"color"]];
    [self.msgNum setTintColor:[info objectForKey:@"color"]];
    [self.msgIcon setImage:[UIImage imageNamed:(NSString *)[info objectForKey:@"icon"]]];

    NSString *keyName = (NSString *)[info objectForKey:@"data_key"];
    NSString *msgNum = (NSString *)[data objectForKey:keyName];
    self.msgNum.text = msgNum;
}

@end
