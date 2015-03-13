//
//  NewWineViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/24/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopWineCategoryViewController.h"
@class TPKeyboardAvoidingScrollView;

@interface NewWineViewController : UIViewController<TopWineCategoryViewControllerDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *wineName;
@property (weak, nonatomic) IBOutlet UIButton *wineCategoryBtn;
@property (weak, nonatomic) IBOutlet UITextView *wineDesc;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

- (IBAction)selectWineCategory:(id)sender;
- (IBAction)submit:(id)sender;
@end
