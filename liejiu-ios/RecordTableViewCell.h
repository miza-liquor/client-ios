//
//  RecordTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 2/15/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recordCover;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *wineName;
@property (weak, nonatomic) IBOutlet UILabel *recordDesc;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *msgNum;
@property (weak, nonatomic) IBOutlet UILabel *address;

- (IBAction)clickOnMenu:(id)sender;
- (void) setRecordData:(NSDictionary *) data;

@end
