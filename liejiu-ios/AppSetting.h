//
//  AppSetting.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/28/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface AppSetting : NSObject

+ (BOOL) isLoginUser;
+ (void) setLoginStatus:(BOOL)status;

+ (NSString *) getHostName;
+ (NSString *) getApiLink:(NSString *)routeName;

+ (id) getCache:(NSString *)cacheName;
+ (void) removeCache:(NSString *)cacheName;
+ (void) setCache:(NSString *)cacheName value:(id)value;
+ (void) setCurrViewController:(UIViewController *) view;


// setting a http post request
+ (void) httpPost:(NSString *)route
                parameters: (NSDictionary *)parameters
                callback:(void (^)(BOOL success, NSDictionary *response, NSString *msg))callback;

// setting a http get request
+ (void) httpGet:(NSString *)route
       parameters: (NSDictionary *)parameters
         callback:(void (^)(BOOL success, NSDictionary *response, NSString *msg))callback;

+ (BOOL) emailRegex:(NSString *)email;

+ (void) settingLabel:(UILabel *)label withAttribute:(NSDictionary *)attribute inSelectedText:(NSString *)text;

+ (void) drawToolBar:(UIViewController *)view;

+ (void) topBarStyleSetting:(UIViewController *)view;

+ (NSString *) getCurrentVersion;

+ (void) shareInView:(UIViewController *)view WithText:(NSString *)text shareImage:(UIImage *)image;
@end
