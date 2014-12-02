//
//  UserProfileInfoTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserProfileInfoTableViewCellDelegate

- (void) onTagChanged: (NSString *) tabName;
- (void) onClickFollowBtn: (NSString *) followType;

@end


@interface UserProfileInfoTableViewCell : UITableViewCell

@property (nonatomic, weak) id <UserProfileInfoTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *followNum;
@property (weak, nonatomic) IBOutlet UIButton *followerNum;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *level;

- (IBAction) clickOnTab:(id)sender;
- (IBAction)clickONFollowInfoBtn:(id)sender;

@end
