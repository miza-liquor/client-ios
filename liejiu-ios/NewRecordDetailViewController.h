//
//  NewRecordDetailViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/24/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuListViewController.h"
#import "WineSelectViewController.h"
@class TPKeyboardAvoidingScrollView;

@interface NewRecordDetailViewController : UIViewController <MenuListViewControllerDelegate, WineSelectViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *recordDesc;
@property (weak, nonatomic) IBOutlet UIImageView *recordImage;
@property (weak, nonatomic) IBOutlet UIButton *recordAddress;
@property (weak, nonatomic) IBOutlet UIButton *recordMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *wineName;

@property (nonatomic) UIImage *previewImage;

- (IBAction)addAddress:(id)sender;
- (IBAction)addMenu:(id)sender;
- (IBAction)submitRecord:(id)sender;
- (IBAction)addWineName:(id)sender;
@end
