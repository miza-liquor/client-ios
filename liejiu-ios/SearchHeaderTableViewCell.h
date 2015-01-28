//
//  SearchHeaderTableViewCell.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/27/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchHeaderTableViewCellDelegate

- (void) submitSearchBox: (NSString *) keywork;

@end


@interface SearchHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchBox;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeBtn;
- (IBAction)clickOnSearchBtn:(id)sender;

@property (nonatomic, weak) id <SearchHeaderTableViewCellDelegate> delegate;

@end
