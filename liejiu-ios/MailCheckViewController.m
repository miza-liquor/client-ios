//
//  MailCheckViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/4/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "MailCheckViewController.h"
#import "AppSetting.h"
#import "ResetPwdViewController.h"

@interface MailCheckViewController ()

@end

@implementation MailCheckViewController
{
    NSString *code;
    NSString *msgNet;
}

@synthesize mail;
@synthesize sysMsg;

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

- (IBAction)clickOnCheck:(id)sender
{
    code = self.mailCheckBox.text;
    code = [code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    self.msg.text = @"";
    [self.msg setHidden:NO];
    
    if ([code length] == 0)
    {
        self.msg.text = @"请填写验证码";
        return;
    }
    
    NSDictionary *param = @{@"mail": mail, @"code": code};
    [AppSetting httpPost:@"pwd/codecheck" parameters:param callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES) {
            self.msg.text = @"";
            msgNet =(NSString *)[response objectForKey:@"data"];
            [self performSegueWithIdentifier:@"reset" sender:self];
        } else {
            self.msg.text = (NSString *)[response objectForKey:@"data"];
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"reset"])
    {
        ResetPwdViewController *vc = segue.destinationViewController;
        vc.mail = mail;
        vc.code = code;
        vc.sysMsg = msgNet;
    }
}
@end
