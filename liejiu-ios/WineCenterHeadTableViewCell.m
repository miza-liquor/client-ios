//
//  WineCenterHeadTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/7/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "WineCenterHeadTableViewCell.h"
#import "AppSetting.h"

@implementation WineCenterHeadTableViewCell
{
    CGFloat initHeight;
    CGFloat rowHeight;
    NSMutableArray *categories;
    BOOL showAll;
}

- (void)awakeFromNib
{
    // Initialization code
    CGRect size = CGRectMake(0, 0, 24, 24);
    self.searchBtn.imageView.layer.cornerRadius = self.searchBtn.imageView.layer.frame.size.height/2;
    self.searchBtn.imageView.layer.masksToBounds = YES;
    [self.searchBtn.imageView setFrame:size];
    [self.searchBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];

    self.searchBox.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1] CGColor];
    self.searchBox.layer.borderWidth= 1.0f;
    
    [self.searchBox addTarget:self action:@selector(clickOnSearchBtn:) forControlEvents:UIControlEventEditingDidEndOnExit];

    initHeight = self.searchBtn.layer.frame.size.height + 20;
    rowHeight = initHeight + 30;
    
    showAll = NO;
    [self loadCategoryData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickOnSearchBtn:(id)sender
{
    
    NSString *keyword = self.searchBox.text;
    keyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.delegate submitSearchBox:keyword];
}

- (void) loadCategoryData
{
    categories = [(NSArray *)[AppSetting getCache:@"wineCategory"] mutableCopy];
    if (categories == Nil)
    {
        [AppSetting httpGet:@"winecategory" parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            if (success == YES)
            {
                categories = [(NSArray *)[response objectForKey:@"data"] mutableCopy];
                [AppSetting setCache:@"wineCategory" value:categories];
                [self setData:categories];
            }
        }];
    } else {
        [self setData:categories];
    }
}

- (void) setData:(NSArray *)data
{
    UIColor *backgroundColor =[UIColor colorWithRed:69.0/255.0 green:153.0/255.0 blue:223.0/255.0 alpha:1];
    UIColor *hlBackgroundColor =[UIColor colorWithRed:96.0/255.0 green:131.0/255.0 blue:244.0/255.0 alpha:1];
    CGRect initSize = CGRectMake(0, 0, 0, 0);
    CGFloat pX = 0.0;
    CGFloat pY = 0.0;
    CGFloat gapX = 5.0;
    CGFloat gapY = 5.0;
    CGFloat lineHeight = 30;
    CGFloat maxWidth = 300;
    CGFloat fontSize = 13;
    NSInteger maxLine = 2;
    NSInteger currLine = 1;
    CGFloat moreBtnWidth = 40;

    [self.loadingLabel removeFromSuperview];
    NSArray *viewsToRemove = [self.categoryContainer subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    CGRect moreBtnSize = CGRectMake(pX, pY, moreBtnWidth, lineHeight);
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:moreBtnSize];
    [moreBtn setTitle:@"  ...  " forState:UIControlStateNormal];
    [moreBtn setBackgroundColor: backgroundColor];
    [self.categoryContainer addSubview:moreBtn];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [moreBtn setTag:-1];
    [moreBtn addTarget:self action:@selector(clickOnCategory:) forControlEvents: UIControlEventTouchUpInside];
    [self.categoryContainer addSubview:moreBtn];
    
    for (NSInteger i = 0, l = [data count]; i < l; i++)
    {
        NSDictionary *info = (NSDictionary *)[data objectAtIndex:i];
        NSString *selected = (NSString *)[info objectForKey:@"selected"];
        NSString *title =  [NSString stringWithFormat:@"  %@  ", (NSString *)[info objectForKey:@"name"]];
        UIButton *btn = [[UIButton alloc] initWithFrame:initSize];
        if ([selected isEqualToString:@"selected"]) {
            [btn setBackgroundColor:hlBackgroundColor];
        } else {
            [btn setBackgroundColor: backgroundColor];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [btn sizeToFit];
        [btn setTag:i];
        
        CGFloat with = btn.layer.frame.size.width;
        
        if (!showAll && currLine == maxLine)
        {
            if ((pX + moreBtnWidth) > maxWidth || (pX + with) > maxWidth) {
                [moreBtn setFrame: CGRectMake(pX, pY, moreBtnWidth, lineHeight)];
                break;
            }
        }
        
        if (pX + with > maxWidth)
        {
            pX = 0;
            pY += lineHeight + gapY;
            currLine += 1;
        }
        
        [btn.layer setFrame:CGRectMake(pX, pY, btn.layer.frame.size.width, lineHeight)];
        pX += with + gapX;
        
        [btn addTarget:self action:@selector(clickOnCategory:) forControlEvents: UIControlEventTouchUpInside];
        
        [self.categoryContainer addSubview:btn];
    }
    
    if (showAll) {
        if (pX + moreBtnWidth > maxWidth)
        {
            pX = 0;
            pY += lineHeight + gapY;
        }
        [moreBtn setFrame: CGRectMake(pX, pY, moreBtnWidth, lineHeight)];
    }
    
    
    rowHeight = pY + 10 + lineHeight + initHeight;
    
    [self.delegate categoryDataReady];
}

-(void)clickOnCategory:(id)sender
{
    
    NSInteger tag = [sender tag];
    NSMutableArray *newCategories = [[NSMutableArray alloc] initWithCapacity:[categories count]];
    
    if (tag < 0)
    {
        showAll = !showAll;
        [self setData:categories];
        [self.delegate clickOnCategoryBtn:nil];
    } else {
        NSString *selected = @"selected";
        for (NSInteger i=0,l=[categories count]; i<l; i++) {
            NSMutableDictionary *info = [(NSDictionary *)[categories objectAtIndex:i] mutableCopy];
            if (i==tag){
                NSString *isSelected = (NSString *)[info objectForKey:selected];
                if ([isSelected isEqualToString:selected]) {
                    [info removeObjectForKey:selected];
                    [self.delegate clickOnCategoryBtn:nil];
                } else {
                    [info removeObjectForKey:selected];
                    [info setObject:selected forKey:selected];
                    [self.delegate clickOnCategoryBtn:(NSDictionary *)[categories objectAtIndex:tag]];
                }
            }else{
                [info removeObjectForKey:selected];
            }
            [newCategories addObject:info];
        }
        
        categories = newCategories;
        // redraw button
        [self setData:categories];
    }
}

- (CGFloat) getRowHeight
{
    return rowHeight;
}
@end
