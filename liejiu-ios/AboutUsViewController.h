//
//  AboutUsViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NJKWebViewProgress.h>

@interface AboutUsViewController : UIViewController<NJKWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
