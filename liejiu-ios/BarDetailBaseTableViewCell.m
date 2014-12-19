//
//  BarDetailBaseTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 12/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "BarDetailBaseTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BarDetailBaseTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.barImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setBarBasicInfo:(NSDictionary *)barBasicInfo
{
    NSString *barName;
    NSString *address = (NSString *)[barBasicInfo objectForKey:@"address"];
    
    if ([address length] == 0)
    {
        barName = (NSString *)[barBasicInfo objectForKey:@"name"];
    } else {
        barName = [NSString stringWithFormat:@"%@(%@)", (NSString *)[barBasicInfo objectForKey:@"name"], address];
    }
    
    self.barName.text = barName;
    [self.barImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[barBasicInfo objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    self.barLocation.text =(NSString *)[barBasicInfo objectForKey:@"city"];
    self.checkinNum.text =[[barBasicInfo objectForKey:@"checkin_num"] stringValue];
}

@end
