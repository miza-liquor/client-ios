//
//  MenuWineImagesTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/29/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "MenuWineImagesTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MenuWineImagesTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.wineImage.layer.masksToBounds = YES;
    
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

- (void) setWineData:(NSDictionary *) data
{
    [self.wineImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    self.wineName.text = (NSString *)[data objectForKey:@"c_name"];
}

@end
