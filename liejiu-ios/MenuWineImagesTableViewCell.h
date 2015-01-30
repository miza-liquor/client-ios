//
//  MenuWineImagesTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/29/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuWineImagesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *wineImage;
@property (weak, nonatomic) IBOutlet UILabel *wineName;

- (void) setWineData:(NSDictionary *) data;

@end
