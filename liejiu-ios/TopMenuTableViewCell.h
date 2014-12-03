//
//  TopMenuTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *wineImage1;
@property (weak, nonatomic) IBOutlet UIImageView *wineImage2;
@property (weak, nonatomic) IBOutlet UIImageView *wineImage3;
@property (weak, nonatomic) IBOutlet UIImageView *wineImage4;
@property (weak, nonatomic) IBOutlet UIImageView *wineImage5;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *menuName;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;

- (void) setTopMenuData:(NSDictionary *)data;

@end
