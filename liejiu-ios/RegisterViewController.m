//
//  RegisterViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppSetting.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickRegisterBtn:(id)sender
{
    NSString *email = self.email.text;
    NSString *userName = self.userName.text;
    NSString *pwd = self.pwd.text;
    NSString *pwdRepeat = self.pwdRepeat.text;
    BOOL passCheck = YES;
    
    email = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    userName = [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    pwd = [pwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    pwdRepeat = [pwdRepeat stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [self.msgMail setHidden:NO];
    [self.msgUserName setHidden:NO];
    [self.msgPwd setHidden:NO];
    [self.msgPwdRepeat setHidden:NO];
    [self.msgRigister setHidden:NO];
    [self.msgRigister setHidden:NO];
    [self.msgPwdRepeat setHidden:YES];
    
    if ([email length] == 0)
    {
        self.msgMail.text = @"邮箱不能为空";
        passCheck = NO;
    } else if ([AppSetting emailRegex:email]) {
        self.msgMail.text = @"邮箱格式不正确";
        passCheck = NO;
    } else {
        [self.msgMail setHidden:YES];
    }
    
    if ([userName length] == 0)
    {
        self.msgUserName.text = @"用户名不能为空";
        passCheck = NO;
    } else if ([userName length] < 8)
    {
        self.msgUserName.text = @"用户名长度不能少于8个字符";
        passCheck = NO;
    } else if ([userName length] > 32)
    {
        self.msgUserName.text = @"用户名长度不能多于32个字符";
        passCheck = NO;
    } else {
        [self.msgUserName setHidden:NO];
    }
    
    if ([pwd length] == 0)
    {
        self.msgPwd.text = @"密码不能为空";
        passCheck = NO;
    } else if ([pwd length] < 6)
    {
        self.msgPwd.text = @"密码长度不能少于6个字符";
        passCheck = NO;
    } else if ([pwd length] > 16)
    {
        self.msgPwd.text = @"密码长度不能多于32个字符";
        passCheck = NO;
    } else {
        [self.msgPwd setHidden:YES];
        if (![pwdRepeat isEqualToString:pwd])
        {
            self.msgPwdRepeat.text = @"两次密码不一致";
            [self.msgPwdRepeat setHidden:NO];
            passCheck = NO;
        }
    }
    
    if (!passCheck)
    {
        return;
    }
    
    self.msgRigister.text = @"正在注册";
    NSDictionary *paramers = @{@"email": email, @"username": userName, @"pwd": pwd, @"cpwd": pwdRepeat};
    [AppSetting httpPost:@"register" parameters:paramers callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        
    }];
}
@end
