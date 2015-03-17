//
//  UserSettingViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/22/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "UserSettingViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AppSetting.h"

@interface UserSettingViewController ()

@end

@implementation UserSettingViewController
{
    NSDictionary *userInfo;
    BOOL isUpdatingBasic;
    BOOL isUpdatingPwd;
}
@synthesize scrollView;

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
    
    isUpdatingBasic = NO;
    isUpdatingPwd = NO;

    [self.scrollView contentSizeToFit];
    userInfo = (NSDictionary *)[AppSetting getCache:@"userInfo"];
    self.nickName.text = (NSString *)[userInfo objectForKey:@"nickname"];
    self.city.text = (NSString *)[userInfo objectForKey:@"city"];

    NSString *gender = (NSString *)[userInfo objectForKey:@"gender"];
    if ([gender isEqualToString:@"male"]) {
        self.gender.selectedSegmentIndex = 0;
    } else if ([gender isEqualToString:@"female"]) {
        self.gender.selectedSegmentIndex = 1;
    }

    [self.basicMsg setHidden:YES];
    [self.pwdMsg setHidden:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void) viewWillDisAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
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

- (IBAction)clickOnResetPwd:(id)sender
{
    if (isUpdatingPwd) return;

    [self.pwdMsg setHidden:NO];
    
    NSString *old = [self.currentPwd.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSString *new = [self.password.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSString *newRepeat = [self.pwdRepeat.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ([old length] == 0) {
        self.pwdMsg.text = @"密码不能为空";
        return;
    }
    
    if ([new length] == 0) {
        self.pwdMsg.text = @"新密码不能为空";
        return;
    }
    
    if ([new length] < 6) {
        self.pwdMsg.text = @"密码不能少于6位";
        return;
    }
    
    if (![new isEqualToString:newRepeat]) {
        self.pwdMsg.text = @"两次密码不一致";
        return;
    }
    
    self.pwdMsg.text = @"正在更改密码...";
    
    NSDictionary *params = @{
                             @"old": old,
                             @"new": new,
                             @"new_repeat": newRepeat
                             };
    
    [AppSetting httpPost:@"user/update/password" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success) {
            self.pwdMsg.text = @"更新成功";
        } else {
            self.pwdMsg.text = msg;
        }
    }];
}

- (IBAction)clickOnUpdateBasicInfo:(id)sender
{
    if (isUpdatingBasic) return;
    
    [self.basicMsg setHidden:NO];
    self.basicMsg.text = @"正在更新基本信息...";
    
    NSString *nickname = [self.nickName.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSInteger gender = self.gender.selectedSegmentIndex;
    NSString *city = [self.city.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    NSDictionary *params = @{
                             @"nickname": nickname,
                             @"gender": (gender == 0) ? @"male" : @"female",
                             @"city": city
                             };
    [AppSetting httpPost:@"user/update/basic" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success) {
            self.basicMsg.text = @"更新成功";
        } else {
            self.basicMsg.text = msg;
        }
    }];
}

- (void) setUserInfo:(NSDictionary *)data
{
    userInfo = data;
    
    
}
@end
