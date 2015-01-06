//
//  TopWineTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopWineTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"

@implementation TopWineTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.image.layer.cornerRadius = 1;
    self.image.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 2;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 6;
    frame.origin.y += 3;
    
    frame.size.width -= 12;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setWineData:(NSDictionary *)data
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    self.category.text = (NSString *)[data objectForKey:@"category_name"];
    self.name.text = (NSString *)[data objectForKey:@"c_name"];
    self.score.text = [NSString stringWithFormat:@"%@/%@", (NSString *)[data objectForKey:@"score_value"], (NSString *)[data objectForKey:@"score_num"]];
    
    NSDictionary *highLightColor = @{NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1]};
    NSString *drinkedNum = [NSString stringWithFormat:@"%@", [[data objectForKey:@"drinked"] stringValue]];
    self.drinked.text = [NSString stringWithFormat:@"喝过 %@", drinkedNum];
    [AppSetting settingLabel:self.drinked withAttribute:highLightColor inSelectedText:drinkedNum];
}

@end
