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

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
}

- (void)awakeFromNib
{
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.frame.size.height/2;
    self.userImage.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:163.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 5;
//    frame.origin.y -= 1;
    
    frame.size.width -= 10;
    frame.size.height += 1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) populateWithObject:(id)object
{
    NSDictionary *comment = object;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[comment objectForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    self.comment.text = (NSString *)[comment objectForKey:@"content"];
}

@end
