//
//  ForgetPwdViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPwdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mailBox;
@property (weak, nonatomic) IBOutlet UILabel *msg;
- (IBAction)clickOnBtn:(id)sender;

@end
