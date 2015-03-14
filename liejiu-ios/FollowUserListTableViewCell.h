//
//  FollowUserListTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FollowUserListTableViewCellDelegate

- (void) onFollowBtn: (NSDictionary *) userInfo;

@end

@interface FollowUserListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *recordNum;
@property (weak, nonatomic) IBOutlet UILabel *menuNum;
@property (weak, nonatomic) IBOutlet UIButton *btn;

- (void) setData:(NSDictionary*)data;
- (IBAction)clickOnFollowBtn:(id)sender;

@property (nonatomic, weak) id <FollowUserListTableViewCellDelegate> delegate;
@end
