//
//  TopUserTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TopUserTableViewCellDelegate

- (void) followUser: (NSString *) userID;

@end

@interface TopUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *recommand;
- (IBAction)clickOnFollowBtn:(id)sender;

- (void) setUserData:(NSDictionary *)data;
@property (nonatomic, strong) id <TopUserTableViewCellDelegate> delegate;

@end
