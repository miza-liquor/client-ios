//
//  WineCreatorTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WineCreatorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UILabel *recordNum;
@property (weak, nonatomic) IBOutlet UILabel *menuNum;

-(void) setCreatorInfo: (NSDictionary *)info;

@end
