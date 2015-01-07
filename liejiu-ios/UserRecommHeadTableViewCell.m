//
//  UserRecommHeadTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/7/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "UserRecommHeadTableViewCell.h"

@implementation UserRecommHeadTableViewCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickOnSearchBtn:(id)sender
{
    NSString *keyword = self.searchBox.text;
    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    keyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.delegate submitSearchBox:keyword];
    
    [self.delegate submitSearchBox:keyword];
}
@end
