//
//  LoginViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "LoginViewController.h"
#import "AppSetting.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    [self.loginMsg setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) clickOnLoginBtn:(id)sender
{
    // reset content & show msg label
    self.loginMsg.text = @"";
    [self.loginMsg setHidden:NO];
    
    // get username & pwd
    NSString *userName = self.userName.text;
    NSString *pwd = self.pwd.text;
    // remove space
    userName = [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    pwd = [pwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([userName length] == 0 || [pwd length] == 0)
    {
        self.loginMsg.text = @"登录名或密码不能为空";
        return;
    }
    
    // try to login
    self.loginMsg.text = @"正在登陆...";
    NSDictionary *parameters = @{@"uname": userName, @"pwd": pwd};
    
    [AppSetting httpPost:@"login" parameters:parameters callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            // after check login, go to explore page
            NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
            [AppSetting setLoginStatus:YES];
            [AppSetting setCache:@"userInfo" value:(NSDictionary *) [data objectForKey:@"user"]];
            [AppSetting setCache:@"topImage" value:(NSDictionary *) [data objectForKey:@"top_image"]];
            [AppSetting setCache:@"topMenu" value:(NSDictionary *) [data objectForKey:@"top_menu"]];

            self.navigationController.navigationBarHidden = YES;
            [self performSegueWithIdentifier:@"explore" sender:self];
        } else {
            self.loginMsg.text = msg;
        }
    }];
}

@end
