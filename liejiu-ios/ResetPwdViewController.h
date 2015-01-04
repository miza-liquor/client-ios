//
//  ResetPwdViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/4/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPwdViewController : UIViewController

@property (nonatomic) NSString *mail;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *sysMsg;

@property (weak, nonatomic) IBOutlet UILabel *sysMsgLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *repeatPwd;
@property (weak, nonatomic) IBOutlet UILabel *msg;
@property (weak, nonatomic) IBOutlet UIButton *reloginBtn;

- (IBAction)clickOnReset:(id)sender;
- (IBAction)clickOnReloginBtn:(id)sender;

@end
