//
//  WineDrinkUserTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WineDrinkUserTableViewCellDelegate

- (void) onTagUserImage: (NSDictionary *) userInfo;

@end

@interface WineDrinkUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnImage1;
@property (weak, nonatomic) IBOutlet UIButton *btnImage2;
@property (weak, nonatomic) IBOutlet UIButton *btnImage3;
@property (weak, nonatomic) IBOutlet UIButton *btnImage4;
@property (weak, nonatomic) IBOutlet UIButton *btnImage5;
@property (weak, nonatomic) IBOutlet UIButton *btnImage6;
- (IBAction)clickOnUser:(id)sender;

- (void) setGroupData:(NSArray *)data;
@property (nonatomic, weak) id <WineDrinkUserTableViewCellDelegate> delegate;

@end
