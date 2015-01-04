//
//  ResetPwdViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/4/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "LoginViewController.h"
#import "AppSetting.h"

@interface ResetPwdViewController ()

@end

@implementation ResetPwdViewController

@synthesize sysMsg;
@synthesize mail;
@synthesize code;

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
    
    [self.msg setHidden:YES];
    [self.reloginBtn setHidden:YES];
    self.sysMsgLabel.text = sysMsg;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickOnReset:(id)sender
{
    [self.pwd resignFirstResponder];
    [self.repeatPwd resignFirstResponder];
    NSString *pwd = self.pwd.text;
    NSString *rPwd = self.repeatPwd.text;
    
    pwd = [pwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    rPwd = [rPwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    self.msg.text = @"";
    [self.msg setHidden:NO];
    
    if ([pwd length] == 0)
    {
        self.msg.text = @"请填写验证码";
        return;
    }
    
    if ([pwd length] < 6){
        self.msg.text = @"密码不能少于6个字符";
        return;
    }
    
    if ([pwd length] > 32){
        self.msg.text = @"密码不能多于32个字符";
        return;
    }
    
    if (![rPwd isEqualToString:pwd])
    {
        self.msg.text = @"两次密码不一致";
        return;
    }
    
    NSDictionary *param = @{@"mail": mail, @"code": code, @"pwd": pwd, @"n_pwd": rPwd};
    [AppSetting httpPost:@"pwd/resetpwd" parameters:param callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES) {
            [self.reloginBtn setHidden:NO];
            self.msg.text = (NSString *)[response objectForKey:@"data"];
        } else {
            self.msg.text = (NSString *)[response objectForKey:@"data"];
        }
    }];
}

- (IBAction)clickOnReloginBtn:(id)sender
{
    LoginViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
