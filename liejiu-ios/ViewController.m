//
//  ViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
}

- (void) viewWillAppear:(BOOL)animated
{
    // disable the navbar
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    // disable the navbar
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
