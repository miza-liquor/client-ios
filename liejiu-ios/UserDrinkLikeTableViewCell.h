//
//  UserDrinkLikeTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDrinkLikeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *wine1;
@property (weak, nonatomic) IBOutlet UIButton *wine2;
@property (weak, nonatomic) IBOutlet UIButton *wine3;
@property (weak, nonatomic) IBOutlet UIButton *wine4;

- (void) setGroupData:(NSArray *)data;

@end
