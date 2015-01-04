//
//  RegisterViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppSetting.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"

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
    
    [self.scrollView contentSizeToFit];
}

- (void) viewWillAppear:(BOOL)animated
{
    // disable the navbar
    self.navigationController.navigationBarHidden = NO;
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
    } else if (![AppSetting emailRegex:email]) {
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
        [self.msgUserName setHidden:YES];
    }
    
    if ([pwd length] == 0)
    {
        self.msgPwd.text = @"密码不能为空";
        passCheck = NO;
    } else if ([pwd length] < 6)
    {
        self.msgPwd.text = @"密码长度不能少于6个字符";
        passCheck = NO;
    } else if ([pwd length] > 32)
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
        self.msgRigister.text = @"输入有错误";
        return;
    }
    
    self.msgRigister.text = @"正在注册";
    NSDictionary *paramers = @{@"email": email, @"username": userName, @"pwd": pwd, @"cpwd": pwdRepeat};
    [AppSetting httpPost:@"register" parameters:paramers callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            self.msgRigister.text = @"注册成功";
            // after check login, go to explore page
            NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
            [AppSetting setLoginStatus:YES];
            [AppSetting setCache:@"userInfo" value:(NSDictionary *) [data objectForKey:@"user"]];
            [AppSetting setCache:@"topImage" value:(NSDictionary *) [data objectForKey:@"top_image"]];
            [AppSetting setCache:@"topMenu" value:(NSDictionary *) [data objectForKey:@"top_menu"]];
            
            self.navigationController.navigationBarHidden = YES;
            [self performSegueWithIdentifier:@"drawer" sender:self];
        } else {
            self.msgRigister.text = msg;
            
            NSDictionary *errorMsg = (NSDictionary *)[response objectForKey:@"data"];
            NSString *mailErr = (NSString *)[errorMsg objectForKey:@"email"];
            NSString *userNameErr = (NSString *)[errorMsg objectForKey:@"username"];
            NSString *pwdErr = (NSString *)[errorMsg objectForKey:@"password"];
            
            if ([mailErr length] > 0){
                self.msgMail.text = mailErr;
                [self.msgMail setHidden: NO];
            } else {
                [self.msgMail setHidden: YES];
            }
            
            if ([userNameErr length] > 0){
                self.msgUserName.text = mailErr;
                [self.msgUserName setHidden: NO];
            } else {
                [self.msgUserName setHidden: YES];
            }
            
            if ([pwdErr length] > 0){
                self.msgPwd.text = mailErr;
                [self.msgPwd setHidden: NO];
            } else {
                [self.msgPwd setHidden: YES];
            }
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"drawer"]) {
        MMDrawerController *destinationViewController = (MMDrawerController *) segue.destinationViewController;
        
        // Instantitate and set the center view controller.
        UIViewController *centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homepage"];
        [destinationViewController setCenterViewController:centerViewController];
        
        // Instantiate and set the left drawer controller.
        UIViewController *leftDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftSidebar"];
        [destinationViewController setLeftDrawerViewController:leftDrawerViewController];
        
        // drawer setting
        [destinationViewController setShowsShadow:YES];
        [destinationViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeBezelPanningCenterView];
        [destinationViewController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [destinationViewController setMaximumLeftDrawerWidth:260];
        [destinationViewController setDrawerVisualStateBlock: [MMDrawerVisualState slideAndScaleVisualStateBlock]];
        
    }
}
@end
