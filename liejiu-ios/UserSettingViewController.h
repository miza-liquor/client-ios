//
//  UserSettingViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;

@interface UserSettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UILabel *basicMsg;

@property (weak, nonatomic) IBOutlet UITextField *currentPwd;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *pwdRepeat;
@property (weak, nonatomic) IBOutlet UILabel *pwdMsg;



- (IBAction)clickOnResetPwd:(id)sender;
- (IBAction)clickOnUpdateBasicInfo:(id)sender;
@end
