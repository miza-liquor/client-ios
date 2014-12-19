//
//  CommentTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 12/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *comment;
- (void) setCommentData:(NSDictionary *)comment;

@end
