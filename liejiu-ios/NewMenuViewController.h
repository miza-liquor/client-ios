//
//  NewMenuViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;

@protocol NewMenuViewControllerDelegate

- (void) addNewMenu: (NSString *) menuID;

@end

@interface NewMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *menuName;
@property (weak, nonatomic) IBOutlet UITextView *menuDesc;
- (IBAction) clickOnNewMenuBtn:(id)sender;
@property (nonatomic, weak) id <NewMenuViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *msg;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@end
