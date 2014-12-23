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
    self.infoBg.layer.borderColor = [UIColor colorWithRed:163.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    self.infoBg.layer.borderWidth = 1;
    self.mapView.layer.borderWidth = 1;
    self.mapView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    
    [self checkMap];
}

- (void) checkMap
{
    CGSize size = self.mapView.frame.size;
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.mapView addSubview:mapView];
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
