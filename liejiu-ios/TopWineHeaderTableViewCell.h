//
//  TopWineHeaderTableViewCell.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopWineHeaderTableViewCellDelegate

- (void) clickOnShareBtn;

@end

@interface TopWineHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
- (IBAction) clickOnShareBtn:(id)sender;
@property (nonatomic, weak) id <TopWineHeaderTableViewCellDelegate> delegate;

@end
