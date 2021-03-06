//
//  UserMenuTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *menuImage;
@property (weak, nonatomic) IBOutlet UILabel *menuName;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *wineNum;
@property (weak, nonatomic) IBOutlet UILabel *collectedNum;

- (void) setUserMenu:(NSDictionary*)data;

@end
