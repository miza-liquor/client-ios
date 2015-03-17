//
//  ViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "AppSetting.h"
#import "SSKeychain.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"

@interface ViewController ()

@end

@implementation ViewController
{
    BOOL isLogined;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    UIImage *backgroundImage = [UIImage imageNamed:@"Default-568h"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    UIColor *borderColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    self.btnLogin.layer.borderColor = borderColor.CGColor;
    self.btnRegister.layer.borderColor = borderColor.CGColor;
    
    [AppSetting topBarStyleSetting: self];
    
    isLogined = NO;
    // get username & pwd from keychain
    NSString *serverName = @"liquor-ios";
    NSArray *allAccounts = [SSKeychain accountsForService:serverName];
    if (allAccounts && [allAccounts count] > 0) {
        NSDictionary *accountInfo = (NSDictionary *)[allAccounts objectAtIndex:[allAccounts count] - 1];
        NSString *accountName = (NSString *)[accountInfo objectForKey:@"acct"];
        NSString *pwd = [[NSString alloc] initWithData:[SSKeychain passwordDataForService:serverName account:accountName] encoding:NSUTF8StringEncoding];
        
        [self.btnLogin setHidden:YES];
        [self.btnRegister setHidden:YES];
        [self.btnView setHidden:YES];
        
        NSDictionary *parameters = @{@"uname": accountName, @"pwd": pwd};
        
        [AppSetting httpPost:@"login" parameters:parameters callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            if (success == YES)
            {
                // after check login, go to explore page
                NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
                [AppSetting setLoginStatus:YES];
                [AppSetting setCache:@"userInfo" value:(NSDictionary *) [data objectForKey:@"user"]];
                [AppSetting setCache:@"topImage" value:(NSDictionary *) [data objectForKey:@"top_image"]];
                [AppSetting setCache:@"topMenu" value:(NSDictionary *) [data objectForKey:@"top_menu"]];
                
                isLogined = YES;
                self.navigationController.navigationBarHidden = YES;
                [self performSegueWithIdentifier:@"drawer" sender:self];
            } else {
                self.loadingMsg.text = msg;
            }
        }];
    } else {
        [self.loading setHidden:YES];
        [self.loadingMsg setHidden:YES];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    // disable the navbar
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    // disable the navbar
    if (!isLogined) {
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
