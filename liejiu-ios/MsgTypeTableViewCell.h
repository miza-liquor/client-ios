//
//  MsgTypeTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/11/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *msgIcon;
@property (weak, nonatomic) IBOutlet UILabel *msgTitle;
@property (weak, nonatomic) IBOutlet UILabel *msgNum;

- (void) setMsgData: (NSDictionary *)num inIndex:(NSInteger)index;

@end
