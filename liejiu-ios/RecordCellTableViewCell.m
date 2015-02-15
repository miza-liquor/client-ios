//
//  RecordCellTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 2/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "RecordCellTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RecordCellTableViewCell

- (void)awakeFromNib
{
    // Initialization code

    self.recordImage.layer.cornerRadius = self.recordImage.layer.frame.size.width/2;
    self.recordImage.layer.masksToBounds = YES;

    struct CGColor *borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderColor = borderColor;
    self.contentView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    NSDictionary *owner = (NSDictionary *)[data objectForKey:@"creator"];
    [self.recordImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    self.recordName.text = (NSString *)[data objectForKey:@"name"];
    self.ownerName.text = (NSString *)[owner objectForKey:@"nickname"];
}

@end