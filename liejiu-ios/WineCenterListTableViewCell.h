//
//  WineCenterListTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WineCenterListTableViewCellDelegate

- (void) addWineToMenuList: (NSString *) wineID;

@end

@interface WineCenterListTableViewCell : UITableViewCell

- (IBAction) clickOnMenuBtn:(id)sender;
@property (nonatomic, weak) id <WineCenterListTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *wineImage;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *wineName;
@property (weak, nonatomic) IBOutlet UILabel *drinkedNum;
@property (weak, nonatomic) IBOutlet UIImageView *userImage1;
@property (weak, nonatomic) IBOutlet UIImageView *userImage2;
@property (weak, nonatomic) IBOutlet UIImageView *userImage3;
@property (weak, nonatomic) IBOutlet UIImageView *userImage4;
@property (weak, nonatomic) IBOutlet UIImageView *userImage5;
@property (weak, nonatomic) IBOutlet UIImageView *userImage6;

@end
