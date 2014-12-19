//
//  CommentTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 12/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "CommentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CommentTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.frame.size.height/2;
    self.userImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCommentData:(NSDictionary *)comment
{
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[comment objectForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    self.comment.text = (NSString *)[comment objectForKey:@"content"];
}

@end
