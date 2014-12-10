//
//  DrawerTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 12/10/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *notic;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@end
