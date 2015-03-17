//
//  RecordTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 2/15/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "RecordTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"

@implementation RecordTableViewCell
{
    NSMutableDictionary *recordInfo;
}

- (void)awakeFromNib
{
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width/2;
    self.userImage.layer.masksToBounds = YES;
    self.recordCover.layer.masksToBounds = YES;
    
    struct CGColor *borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderColor = borderColor;
    self.contentView.layer.borderWidth = 1;
    self.toolBg.layer.borderColor = borderColor;
    self.toolBg.layer.borderWidth = 1;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 5;
    frame.origin.y += 3;
    
    frame.size.width -= 10;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (void) setRecordData:(NSDictionary *) data
{
    recordInfo = [data mutableCopy];
    NSDictionary *owner = (NSDictionary *)[data objectForKey:@"creator"];
    [self.recordCover sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[owner objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    

    NSString *menuNum = [NSString stringWithFormat:@" 加入酒单 (%@)", (NSString *)[data objectForKey:@"menu_num"]];
    [self.menuBtn setTitle:menuNum forState:UIControlStateNormal];

    self.userName.text = (NSString *)[owner objectForKey:@"nickname"];
    self.createdAt.text = (NSString *)[data objectForKey:@"created_at"];
    self.wineName.text = (NSString *)[data objectForKey:@"name"];
    self.recordDesc.text = (NSString *)[data objectForKey:@"desc"];
    self.address.text = (NSString *)[data objectForKey:@"address"];
    [self.likeBtn setTitle:(NSString *)[data objectForKey:@"like_num"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:(NSString *)[data objectForKey:@"comment_num"] forState:UIControlStateNormal];
    
    BOOL meLiked = (BOOL)[[data objectForKey:@"me_liked"] boolValue];
    if (meLiked) {
        [self.likeBtn setImage:[UIImage imageNamed:@"icon_liked"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickOnMenu:(id)sender {
    [self.delegate addMenu:recordInfo];
}

- (IBAction)clickOnLike:(id)sender {
    BOOL meLiked = (BOOL)[[recordInfo objectForKey:@"me_liked"] boolValue];
    NSDictionary *params = @{
                             @"content_id": (NSString *)[recordInfo objectForKey:@"id"],
                             @"category": @"record",
                             @"status": meLiked ? @"0" : @"1"
                            };
    [AppSetting httpPost:@"update/like" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success) {
            NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
            BOOL meLiked = (BOOL)[[data objectForKey:@"me_liked"] boolValue];
            [self.likeBtn setTitle:(NSString *)[data objectForKey:@"like_num"] forState:UIControlStateNormal];
            if (meLiked) {
                [self.likeBtn setImage:[UIImage imageNamed:@"icon_liked"] forState:UIControlStateNormal];
            } else {
                [self.likeBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
            }
            
            [recordInfo setValue:[data objectForKey:@"me_liked"] forKey:@"me_liked"];
            [recordInfo setValue:[data objectForKey:@"like_num"] forKey:@"like_num"];

        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新失败" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (IBAction)clickOnComment:(id)sender {
}
@end
