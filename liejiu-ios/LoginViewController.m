//
//  LoginViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "LoginViewController.h"
#import "AppSetting.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    BOOL isLoading;
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
    
    [self.scrollView contentSizeToFit];
    
    isLoading = NO;

    // setting bg
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_login@2x"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    // input padding setting
    UIImageView *iconUserName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_login_username"]];
    iconUserName.frame = CGRectMake(0.0, 0.0, iconUserName.image.size.width+30.0, iconUserName.image.size.height);
    iconUserName.contentMode = UIViewContentModeCenter;
    self.userName.leftView = iconUserName;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *iconPwd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_login_pwd"]];
    iconPwd.frame = CGRectMake(0.0, 0.0, iconPwd.image.size.width+30.0, iconPwd.image.size.height);
    iconPwd.contentMode = UIViewContentModeCenter;
    self.pwd.leftView = iconPwd;
    self.pwd.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self.loginMsg setHidden:YES];
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

- (IBAction) clickOnLoginBtn:(id)sender
{
    if (isLoading)
    {
        return;
    }
    
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
    isLoading = YES;
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
            [self performSegueWithIdentifier:@"drawer" sender:self];
        } else {
            self.loginMsg.text = msg;
        }
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    // disable the navbar
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
