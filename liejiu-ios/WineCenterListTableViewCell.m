//
//  WineCenterListTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "WineCenterListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"

@implementation WineCenterListTableViewCell
{
    NSArray *userList;
    NSDictionary *wineInfo;
}


- (void)awakeFromNib
{
    // Initialization code
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;

    self.wineImage.layer.cornerRadius = 1;
    self.wineImage.layer.masksToBounds = YES;
    
    userList = @[self.userImage1, self.userImage2, self.userImage3, self.userImage4, self.userImage5, self.userImage6];
    for (NSInteger i = 0, l = [userList count]; i < l; i++)
    {
        UIImageView *image = (UIImageView *)[userList objectAtIndex:i];
        image.layer.cornerRadius = image.layer.frame.size.height/2;
        image.layer.masksToBounds = YES;
    }
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.origin.y += 3;
    
    frame.size.width -= 20;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction) clickOnMenuBtn:(id)sender
{
    [self.delegate addWineToMenuList: (NSString *)[wineInfo objectForKey:@"id"]];
}

- (void) setData:(NSDictionary *)data
{
    wineInfo = data;
    
    NSString *wineName =(NSString *)[data objectForKey:@"c_name"];
    NSString *wineCatetory =  [NSString stringWithFormat:@"(%@)", (NSString *)[data objectForKey:@"category_name"]];
    NSString *drinkNum = [NSString stringWithFormat:@"%@", [[data objectForKey:@"drinked"] stringValue]];
    NSString *menuNum = [NSString stringWithFormat:@"%@", [[data objectForKey:@"menus"] stringValue]];
    
    [self.wineImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
    self.wineName.text = [NSString stringWithFormat:@"%@ %@", wineName, wineCatetory];
    self.drinkedNum.text = [NSString stringWithFormat:@"喝过 %@", drinkNum];
    [self.menuBtn setTitle:[NSString stringWithFormat:@"加入酒单(%@)", menuNum] forState:UIControlStateNormal];
    [self.menuBtn sizeToFit];
    
    NSDictionary *highLightColor = @{NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1]};
    NSDictionary *lowLightColor = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0],NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1]};
    
    [AppSetting settingLabel:self.wineName withAttribute:lowLightColor inSelectedText:wineCatetory];
    [AppSetting settingLabel:self.drinkedNum withAttribute:highLightColor inSelectedText:drinkNum];
    
    
    NSArray *users = (NSArray *)[data objectForKey:@"drink_user"];
    int totalNum = (int)[userList count];
    int currNum = (int)[users count];
    
    for (int i = 0; i < totalNum; i++) {
        UIImageView *image = (UIImageView *)[userList objectAtIndex:i];
        if (i < currNum)
        {
            NSDictionary *userInfo = [users objectAtIndex:i];
            [image sd_setImageWithURL:[NSURL URLWithString:(NSString *)[userInfo objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
            [image setHidden:NO];
        } else {
            [image setHidden:YES];
        }
    }
    
}

@end
