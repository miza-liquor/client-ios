//
//  ForgetPwdViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "AppSetting.h"
#import "MailCheckViewController.h"

@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController
{
    NSString *mailAddress;
    NSString *sysMsg;
}

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
    
    [self.msg setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    // disable the navbar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

- (IBAction)clickOnBtn:(id)sender
{
    mailAddress = self.mailBox.text;
    mailAddress = [mailAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    self.msg.text = @"";
    [self.msg setHidden:NO];
    
    if ([mailAddress length] == 0)
    {
        self.msg.text = @"邮箱不能为空";
        return;
    }
    
    if (![AppSetting emailRegex:mailAddress])
    {
        self.msg.text = @"邮箱格式不正确";
        return;
    }
    
    self.msg.text = @"正在获取验证码";
    
    NSDictionary *param = @{@"mail": mailAddress};
    [AppSetting httpPost:@"pwd/mailcheck" parameters:param callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES) {
            self.msg.text = @"验证码已经发送至邮箱";
            sysMsg = (NSString *)[response objectForKey:@"data"];
            [self performSegueWithIdentifier:@"mailCheck" sender:self];
        } else {
            self.msg.text = (NSString *)[response objectForKey:@"data"];
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mailCheck"])
    {
        MailCheckViewController *vc = segue.destinationViewController;
        vc.mail = mailAddress;
        vc.sysMsg = sysMsg;
    }
}

@end
