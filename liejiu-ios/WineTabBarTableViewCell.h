//
//  WineTabBarTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WineTabBarTableViewCellDelegate

- (void) onTagChanged: (NSString *) tabName;

@end

@interface WineTabBarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnDrinking;
@property (weak, nonatomic) IBOutlet UIButton *btnDrinked;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToMenu;
- (IBAction)clickOnTabBtn:(id)sender;

@property (nonatomic, weak) id <WineTabBarTableViewCellDelegate> delegate;

-(void) setData:(NSDictionary *)data;

@end
