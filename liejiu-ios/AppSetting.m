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

// api link
static NSString *_hostName = @"http://zhangge.me:8882/v1/app/";

static bool _isLogined = NO;

static NSMutableDictionary *_cacheData = Nil;

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

@end
