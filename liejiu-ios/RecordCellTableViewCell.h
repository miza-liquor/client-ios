//
//  RecordCellTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 2/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recordImage;
@property (weak, nonatomic) IBOutlet UILabel *recordName;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;

- (void) setRecordData:(NSDictionary *) data;

@end
