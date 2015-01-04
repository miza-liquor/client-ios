//
//  MailCheckViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/4/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailCheckViewController : UIViewController

@property (nonatomic) NSString *mail;
@property (nonatomic) NSString *sysMsg;

@property (weak, nonatomic) IBOutlet UILabel *sysMsgLabel;
@property (weak, nonatomic) IBOutlet UITextField *mailCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *msg;
- (IBAction)clickOnCheck:(id)sender;

@end
