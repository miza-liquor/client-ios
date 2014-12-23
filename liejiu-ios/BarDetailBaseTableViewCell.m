//
//  BarDetailBaseTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 12/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "BarDetailBaseTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

@implementation BarDetailBaseTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.barImage.layer.masksToBounds = YES;
    self.infoBg.layer.borderColor = [UIColor colorWithRed:163.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    self.infoBg.layer.borderWidth = 1;
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
    
    NSString *mapUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?width=320&height=180&center=116.344442,39.998499&zoom=17&markers=%@,%@&markerStyles=m,x", (NSString *)[barBasicInfo objectForKey:@"lon"],(NSString *)[barBasicInfo objectForKey:@"lat"]];
    [self.barLocationImage sd_setBackgroundImageWithURL:[NSURL URLWithString:mapUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Icon-29"]];
}

- (IBAction)clickOnMap:(id)sender
{
    [self.delegate gotoMapDetail];
}

@end
