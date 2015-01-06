//
//  WineDetaiHeadTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "WineDetaiHeadTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation WineDetaiHeadTableViewCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"WineDetaiHeadTableViewCell" bundle:nil];
}

- (void)awakeFromNib
{
    // Initialization code
    self.wineImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) populateWithObject:(id)object
{
    NSDictionary *info = object;
    [self.wineImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[info objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    self.wineName.text = (NSString *)[info objectForKey:@"c_name"];
    self.category.text = [NSString stringWithFormat:@"分类:%@", (NSString *)[info objectForKey:@"category_name"]];
    self.maker.text = [NSString stringWithFormat: @"酒商:%@",(NSString *)[info objectForKey:@"maker"]];
    self.country.text = [NSString stringWithFormat: @"国家:%@",(NSString *)[info objectForKey:@"country_name"]];
    self.description.text = (NSString *)[info objectForKey:@"desc"];
//    self.comment.text = (NSString *)[comment objectForKey:@"content"];
}

- (IBAction)clickOnExpandBtn:(id)sender
{
}
@end
