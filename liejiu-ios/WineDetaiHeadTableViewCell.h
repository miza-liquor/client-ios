//
//  WineDetaiHeadTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "DBDynamicHeightTableCell.h"

@interface WineDetaiHeadTableViewCell : DBDynamicHeightTableCell
@property (weak, nonatomic) IBOutlet UILabel *wineName;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *maker;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UIImageView *wineImage;
@property (weak, nonatomic) IBOutlet UILabel *description;
- (IBAction)clickOnExpandBtn:(id)sender;

@end
