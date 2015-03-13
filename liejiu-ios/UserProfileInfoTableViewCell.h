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
- (void) changeUserCover;
- (void) changeBGCover;

@end


@interface UserProfileInfoTableViewCell : UITableViewCell

@property (nonatomic, weak) id <UserProfileInfoTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *followNum;
@property (weak, nonatomic) IBOutlet UIButton *followerNum;
@property (weak, nonatomic) IBOutlet UIButton *likeNum;
@property (weak, nonatomic) IBOutlet UIButton *tabDrinked;
@property (weak, nonatomic) IBOutlet UIButton *tabDrinking;
@property (weak, nonatomic) IBOutlet UIButton *tapMenu;
@property (weak, nonatomic) IBOutlet UIButton *tabCollection;
@property (weak, nonatomic) IBOutlet UIButton *btnUserImage;
@property (weak, nonatomic) IBOutlet UIImageView *userBgCover;

- (IBAction) clickOnTab:(id)sender;
- (IBAction)clickONFollowInfoBtn:(id)sender;
- (IBAction)clickToChangeCover:(id)sender;


- (void) setBasicUserInfo:(NSDictionary *)userBasicInfo withTab:(NSString *)tabName;
- (void) setUserCover:(UIImage *)image;
- (void) setBGCover:(UIImage *)image;

@end
