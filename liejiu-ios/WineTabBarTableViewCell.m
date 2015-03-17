//
//  WineTabBarTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "WineTabBarTableViewCell.h"
#import "AppSetting.h"

@implementation WineTabBarTableViewCell
{
//    NSArray *tabList;
    NSDictionary *msgDic;
    NSDictionary *basicData;
}

- (void)awakeFromNib
{
    // Initialization code
    self.btnDrinked.layer.cornerRadius = 2;
    self.btnDrinking.layer.cornerRadius = 2;
//    self.btnAddToMenu.layer.cornerRadius = 2;
    
    msgDic = @{
               @"drinked": @"喝过的酒友 %@",
               @"drinking": @"想喝的酒友 %@",
            };
    
//    tabList = @[self.btnAddToMenu, self.btnDrinked, self.btnDrinking];
    NSString *defaultTab =@"drinked";
    [self updateTabBtnState:defaultTab];
    [self.delegate onTagChanged:defaultTab];
    
//    [self.btnAddToMenu setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (IBAction)clickOnTabBtn:(id)sender
//{
//    NSString *tagName = [sender restorationIdentifier];
//    [self updateTabBtnState:tagName];
//    [self.delegate onTagChanged:tagName];
//}

-(void) setData:(NSDictionary *)data
{
    basicData = data;
    [self.btnDrinking setTitle:[NSString stringWithFormat:@"想喝 %@", [[data objectForKey:@"drinking"] stringValue]] forState:UIControlStateNormal];
    [self.btnDrinked setTitle:[NSString stringWithFormat:@"喝过 %@", [[data objectForKey:@"drinked"] stringValue]] forState:UIControlStateNormal];
//    [self.btnAddToMenu setTitle:[NSString stringWithFormat:@"加入酒单 %@", [[data objectForKey:@"menus"] stringValue]] forState:UIControlStateNormal];
    
    BOOL isDrinking = (BOOL)[[data objectForKey:@"drinking"] boolValue];
    BOOL isDrinked = (BOOL)[[data objectForKey:@"drinked"] boolValue];
    
    if (isDrinking) {
        [self.btnDrinking setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:117.0/255.0 blue:214.0/255.0 alpha:1]];
    }
    if (isDrinked) {
        [self.btnDrinked setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:117.0/255.0 blue:214.0/255.0 alpha:1]];
    }

    [self updateTabBtnState:@"drinked"];
}

- (void) updateTabBtnState:(NSString *)tabName
{
    if ([tabName isEqualToString:@"menu"])
    {
        return;
    }
//    NSString *num = [NSString stringWithFormat: @"%@", [[basicData objectForKey:tabName] stringValue]];
//    self.titleLabel.text = [NSString stringWithFormat:(NSString *)[msgDic objectForKey:tabName], num];
//    NSDictionary *highLightColor = @{NSForegroundColorAttributeName:[UIColor colorWithRed:244.0/255.0 green:114.0/255.0 blue:100.0/255.0 alpha:1]};
//    [AppSetting settingLabel:self.titleLabel withAttribute:highLightColor inSelectedText:num];
    
//    for (UIButton *tab in tabList) {
//        if ([tabName isEqualToString:(NSString *)[tab restorationIdentifier]])
//        {
//            [tab setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:117.0/255.0 blue:214.0/255.0 alpha:1]];
//        } else {
//            [tab setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:153.0/255.0 blue:223.0/255.0 alpha:1]];
//        }
//    }
}

- (IBAction)clickOnBtnDrinking:(id)sender
{
    BOOL isDrinking = (BOOL)[[basicData objectForKey:@"drinking"] boolValue];
    if (isDrinking) return;
    [self updateStatus:@"0" withBtn:self.btnDrinking];
}

- (IBAction)clickOnBtnDrinked:(id)sender
{
    BOOL isDrinked = (BOOL)[[basicData objectForKey:@"drinked"] boolValue];
    if (isDrinked) return;
    [self updateStatus:@"1" withBtn:self.btnDrinked];
}

- (void) updateStatus:(NSString *)status withBtn:(UIButton *)btn
{
    [btn setTitle:@"加载中..." forState:UIControlStateNormal];
    NSDictionary *params = @{
                             @"type": @"wine",
                             @"content_id": (NSString *)[basicData objectForKey:@"id"],
                             @"drinked": status
                             };
    [AppSetting httpPost:@"drink/update" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        NSString *key = [status isEqualToString:@"0"] ? @"drinking" : @"drinked";
        NSString *keyTitle = [status isEqualToString:@"0"] ? @"想喝" : @"喝过";

        if (success) {
            basicData = (NSDictionary *)[response objectForKey:@"data"];
            [btn setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:117.0/255.0 blue:214.0/255.0 alpha:1]];
        } else {
            
            NSLog(@"%@",msg);
        }
        [btn setTitle:[NSString stringWithFormat:@"%@ %@", keyTitle, [[basicData objectForKey:key] stringValue]] forState:UIControlStateNormal];
    }];
}
@end
