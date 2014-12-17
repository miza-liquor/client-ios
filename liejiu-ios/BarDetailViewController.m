//
//  BarDetailViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "BarDetailViewController.h"

@interface BarDetailViewController ()

@end

@implementation BarDetailViewController
{
    UITextView *inputView;
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
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *flexibleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    // record btn setting
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [sendBtn setImage:[UIImage imageNamed:@"btn_send"] forState:UIControlStateNormal];
    
    inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 240, 32)];
    inputView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    inputView.layer.borderWidth = 1;
    inputView.layer.cornerRadius = 2;
    inputView.layer.masksToBounds = YES;
    
    UIBarButtonItem *barSendBtnBtn = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    UIBarButtonItem *barInput = [[UIBarButtonItem alloc] initWithCustomView:inputView];
    
    [self setToolbarItems:[NSArray arrayWithObjects:barInput, flexibleBtn, barSendBtnBtn, nil]];
    
    self.view.layer.backgroundColor = [UIColor redColor].CGColor;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [inputView resignFirstResponder];
}

#pragma mark -
#pragma mark Notifications

- (void)keyboardWillChange:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat newHeight = self.view.frame.size.height - [self.view convertRect:keyboardRect fromView:nil].origin.y;
    CGRect frame = self.navigationController.toolbar.frame;
    frame.origin.y = self.view.bounds.size.height - newHeight - frame.size.height;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.navigationController.toolbar.frame = frame;
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	/* No longer listen for keyboard */
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
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

@end
