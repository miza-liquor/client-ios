//
//  WineDrinkUserTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "WineDrinkUserTableViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation WineDrinkUserTableViewCell
{
    NSArray *userList;
    NSArray *dataList;
}

- (void)awakeFromNib
{
    // Initialization code
    userList = [[NSArray alloc] initWithObjects:self.btnImage1, self.btnImage2, self.btnImage3, self.btnImage4, self.btnImage5, self.btnImage6, nil];
    
    CGRect size = CGRectMake(0, 0, 45, 45);
    for (UIButton *btn in userList) {
        btn.imageView.layer.cornerRadius = btn.imageView.layer.frame.size.height/2;
        btn.imageView.layer.masksToBounds = YES;
        [btn.imageView setFrame:size];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickOnUser:(id)sender
{
    NSInteger index = [sender tag];
    NSDictionary *userInfo = (NSDictionary *)[dataList objectAtIndex:index];
    [self.delegate onTagUserImage:userInfo];
}

- (void) setGroupData:(NSArray *)data
{
    dataList = data;
    int currNum = (int)[data count];
    int totalPlace = (int)[userList count];
    
    for (int i = 0; i < totalPlace; i++)
    {
        UIButton *btn = (UIButton *)[userList objectAtIndex:i];
        if (i < currNum)
        {
            NSURL *imageURL = [NSURL URLWithString:(NSString *)[(NSDictionary *)[data objectAtIndex:i] objectForKey:@"cover"]];
            [btn sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Icon"]];
            [btn setHidden:NO];
        } else {
            [btn setHidden:YES];
        }
    }
}


@end
