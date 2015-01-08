//
//  AppSetting.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/28/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "AppSetting.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "ExploreViewController.h"
#import "NewRecordViewController.h"
#import "WineCenterViewController.h"
#import "MMDrawerVisualState.h"

// api link
static NSString *_hostName = @"http://zhangge.me:8882/v1/app/";

static bool _isLogined = NO;

static NSMutableDictionary *_cacheData = Nil;

static UIViewController *_currView = nil;

@implementation AppSetting

+ (BOOL) isLoginUser
{
    return _isLogined;
}

+ (void) setLoginStatus:(BOOL)status
{
    _isLogined = status;
}


+ (void) setCache:(NSString *)cacheName value:(__autoreleasing id)value
{
    _cacheData = _cacheData == Nil ? [[NSMutableDictionary alloc] init] : _cacheData;
    [_cacheData setObject:value forKey:cacheName];
}

+ (id)getCache:(NSString *)cacheName
{
    if (_cacheData == Nil)
    {
        return Nil;
    }
    
    return [_cacheData objectForKey:cacheName];
}

+ (void) removeCache:(NSString *)cacheName
{
    [_cacheData removeObjectForKey:cacheName];
}

+ (NSString *) getHostName
{
    return @"http://zhangge.me:8882";
}

+ (NSString *) getApiLink:(NSString *)routeName
{
    return [NSString stringWithFormat:@"%@%@", _hostName, routeName];
}

+ (void) httpPost:(NSString *)route parameters:(NSDictionary *)parameters callback:(void (^)(BOOL, NSDictionary *, NSString *))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = [AppSetting getApiLink:route];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = (NSDictionary *) responseObject;
        int status = [[response objectForKey:@"status"] intValue];
        id responseData = [response objectForKey:@"data"];
        NSString *msg = (NSString *) [response objectForKey:@"msg"];

        if (status == 200 && responseData != Nil)
        {
            callback(YES, response, msg);
        } else {
            callback(NO, response, msg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(NO, nil, @"系统错误");
    }];
}

+ (void) httpGet:(NSString *)route parameters:(NSDictionary *)parameters callback:(void (^)(BOOL, NSDictionary *, NSString *))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = [AppSetting getApiLink:route];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = (NSDictionary *) responseObject;
        int status = [[response objectForKey:@"status"] intValue];
        id responseData = [response objectForKey:@"data"];
        NSString *msg = (NSString *) [response objectForKey:@"msg"];
        
        if (status == 200 && responseData != Nil)
        {
            callback(YES, response, msg);
        } else {
            callback(NO, response, msg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(NO, nil, @"系统错误");
    }];
}

+ (BOOL) emailRegex:(NSString *)email
{
    NSString *regex=@"^[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z\\.]*[a-zA-Z]$";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [regexPredicate evaluateWithObject:email];
}

+ (void) settingLabel:(UILabel *)label withAttribute:(NSDictionary *)attribute inSelectedText:(NSString *)text
{
    NSRange range = [label.text rangeOfString:text];
    if (![label respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:label.text];
    [attributedText setAttributes:attribute range:range];
    label.attributedText = attributedText;
}

+ (void) drawToolBar:(UIViewController *)view
{
    _currView = view;
    UIBarButtonItem *exploreBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_explore"] style:UIBarButtonItemStylePlain target:self action:@selector(navToNewExplorePage:)];
    UIBarButtonItem *winelistBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_winelist"] style:UIBarButtonItemStylePlain target:self action:@selector(navToWineListPage:)];
    UIBarButtonItem *flexibleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    // record btn setting
    UIButton *addRecordView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 68)];
    [addRecordView setImage:[UIImage imageNamed:@"btn_new_record"] forState:UIControlStateNormal];
    [addRecordView addTarget:self action:@selector(navToNewRecordPage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *newRecordBtn = [[UIBarButtonItem alloc] initWithCustomView:addRecordView];

    [view setToolbarItems:[NSArray arrayWithObjects:exploreBtn, flexibleBtn, newRecordBtn, flexibleBtn, winelistBtn, nil]];

    view.navigationController.toolbarHidden = NO;
}

+ (void)navToNewExplorePage:(UIBarButtonItem*)btn
{
    ExploreViewController *controller = [_currView.storyboard instantiateViewControllerWithIdentifier:@"explore"];
    [_currView.navigationController pushViewController:controller animated:YES];
//    controller = nil;
//    _currView = nil;
}

+ (void)navToNewRecordPage:(UIBarButtonItem*)btn
{
    NewRecordViewController *controller = [_currView.storyboard instantiateViewControllerWithIdentifier:@"newRecord"];
    [_currView.navigationController pushViewController:controller animated:YES];
//    controller = nil;
//    _currView = nil;
}

+ (void)navToWineListPage:(UIBarButtonItem*)btn
{
    WineCenterViewController *controller = [_currView.storyboard instantiateViewControllerWithIdentifier:@"wineCenter"];
    [_currView.navigationController pushViewController:controller animated:YES];
//    controller = nil;
//    _currView = nil;
}

+ (void) topBarStyleSetting:(UIViewController *)view
{
    //setting navigation bar bg
    UIImage *image = [UIImage imageNamed:@"bg_navbar.png"];
    [view.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    if ([view.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        view.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        view.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [view.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    } else {
        /* Set background and foreground */
    }
}

@end
