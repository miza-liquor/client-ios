//
//  RegisterProtocalViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 2/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NJKWebViewProgress.h>

@interface RegisterProtocalViewController : UIViewController<NJKWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
