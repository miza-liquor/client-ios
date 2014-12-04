//
//  RecommendBarTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "RecommendBarTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RecommendBarTableViewCell
{
    NSMutableArray *userList;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;
    
    self.checkinImage1.layer.cornerRadius = 22;
    self.checkinImage1.layer.masksToBounds = YES;
    
    self.checkinImage2.layer.cornerRadius = 22;
    self.checkinImage2.layer.masksToBounds = YES;
    
    self.checkinImage3.layer.cornerRadius = 22;
    self.checkinImage3.layer.masksToBounds = YES;
    
    self.checkinImage4.layer.cornerRadius = 22;
    self.checkinImage4.layer.masksToBounds = YES;
    
    self.checkinImage5.layer.cornerRadius = 22;
    self.checkinImage5.layer.masksToBounds = YES;
    
    self.checkinImage6.layer.cornerRadius = 22;
    self.checkinImage6.layer.masksToBounds = YES;
    
    userList = [[NSMutableArray alloc] initWithObjects: self.checkinImage1, self.checkinImage2, self.checkinImage3, self.checkinImage4, self.checkinImage5, self.checkinImage6, nil];
}

- (void) setTopBarData:(NSDictionary *)data
{
//    self.menuName.text = (NSString *)[data objectForKey:@"menu_name"];
    NSLog(@"xxxxxxxx::%@", [data objectForKey:@"image"]);
    [self.barImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    self.location.text =(NSString *)[data objectForKey:@"city"];
    self.checkinNum.text =(NSString *)[data objectForKey:@"checkin_num"];

    NSString *barName = [NSString stringWithFormat:@"%@(%@)", (NSString *)[data objectForKey:@"name"], (NSString *)[data objectForKey:@"address"]];
    NSString *address = (NSString *)[data objectForKey:@"address"];

    if ([address length] == 0)
    {
        barName = (NSString *)[data objectForKey:@"name"];
    } else {
        barName = [NSString stringWithFormat:@"%@(%@)", (NSString *)[data objectForKey:@"name"], address];
    }
    
    self.barName.text = barName;
    
    NSArray *users = (NSArray *)[data objectForKey:@"top_users"];
    int totalNum = [userList count];
    int currNum = [users count];
    
    for (int i = 0; i < totalNum; i++) {
        UIImageView *userImage = (UIImageView *)[userList objectAtIndex:i];
        if (i < currNum)
        {
            NSDictionary *userInfo = (NSDictionary *)[users objectAtIndex:i];
            [userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[userInfo objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
            [userImage setHidden:NO];
        } else {
            [userImage setHidden:YES];
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 6;
    frame.origin.y += 3;
    
    frame.size.width -= 12;
    frame.size.height -= 6;
    [super setFrame:frame];
}

@end
