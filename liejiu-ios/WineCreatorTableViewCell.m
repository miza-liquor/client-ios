//
//  WineCreatorTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "WineCreatorTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"

@implementation WineCreatorTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.height/2;
    self.userImage.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;
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

-(void) setCreatorInfo: (NSDictionary *)info
{
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[info objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    
    NSString *levelNum = [NSString stringWithFormat:@"%@", (NSString *)[info objectForKey:@"level"]];
    NSString *menusNum = [NSString stringWithFormat:@"%@", [[info objectForKey:@"menus"] stringValue]];
    NSString *recordsNum = [NSString stringWithFormat:@"%@", [[info objectForKey:@"wines"] stringValue]];
    
    NSDictionary *highLightColor = @{NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1]};
    
    self.userLevel.text = [NSString stringWithFormat:@"级别:%@", levelNum];
    self.recordNum.text = [NSString stringWithFormat:@"记录数:%@", recordsNum];
    self.menuNum.text = [NSString stringWithFormat:@"酒单:%@", menusNum];
    self.userName.text = (NSString *)[info objectForKey:@"nickname"];
    
    [AppSetting settingLabel:self.userLevel withAttribute:highLightColor inSelectedText:levelNum];
    [AppSetting settingLabel:self.recordNum withAttribute:highLightColor inSelectedText:recordsNum];
    [AppSetting settingLabel:self.menuNum withAttribute:highLightColor inSelectedText:menusNum];
}

@end
