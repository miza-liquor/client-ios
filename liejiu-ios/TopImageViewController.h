//
//  TopImageViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopImageViewController : UIViewController

@property (nonatomic) NSString *url;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
