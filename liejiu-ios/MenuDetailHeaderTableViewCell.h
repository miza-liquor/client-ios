//
//  MenuDetailHeaderTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/29/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "DBDynamicHeightTableCell.h"

@interface MenuDetailHeaderTableViewCell : DBDynamicHeightTableCell
@property (weak, nonatomic) IBOutlet UIImageView *ownerImage;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UILabel *menuName;
@property (weak, nonatomic) IBOutlet UILabel *wineNum;
@property (weak, nonatomic) IBOutlet UILabel *followNum;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIView *metaViewWrap;
- (IBAction)clickOnLiked:(id)sender;

- (CGFloat) getRowHeight;
- (void) setHeaderData: (NSDictionary *) data;

@end
