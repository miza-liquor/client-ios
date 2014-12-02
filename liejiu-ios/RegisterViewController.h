//
//  RegisterViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *pwdRepeat;
@property (weak, nonatomic) IBOutlet UILabel *msgMail;
@property (weak, nonatomic) IBOutlet UILabel *msgUserName;
@property (weak, nonatomic) IBOutlet UILabel *msgPwd;
@property (weak, nonatomic) IBOutlet UILabel *msgPwdRepeat;
@property (weak, nonatomic) IBOutlet UILabel *msgRigister;

- (IBAction)onClickRegisterBtn:(id)sender;

@end
