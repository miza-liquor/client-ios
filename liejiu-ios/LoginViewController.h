//
//  LoginViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UILabel *loginMsg;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

- (IBAction) clickOnLoginBtn:(id)sender;

@end
