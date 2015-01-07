//
//  UserFromRecommandTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserFromRecommandTableViewCellDelegate

- (void) onFollowBtn: (NSDictionary *) userInfo;

@end

@interface UserFromRecommandTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *level;
@property (strong, nonatomic) IBOutlet UILabel *recordNum;
@property (strong, nonatomic) IBOutlet UILabel *menuNum;
@property (strong, nonatomic) IBOutlet UIButton *followBtn;

- (IBAction)clickOnFollowBtn:(id)sender;

- (void) setUserData:(NSDictionary *)userData;

@property (nonatomic, weak) id <UserFromRecommandTableViewCellDelegate> delegate;
@end
