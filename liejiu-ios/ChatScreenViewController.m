//
//  ChatScreenViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/11/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "ChatScreenViewController.h"
#import "BORChatMessage.h"
#import "AppSetting.h"

@interface ChatScreenViewController ()

@end

@implementation ChatScreenViewController
{
    NSDictionary *owner;
    NSString *owner_id;
}


@synthesize userInfo;

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
    
    owner = [AppSetting getCache:@"userInfo"];
    owner_id = (NSString *)[owner objectForKey:@"id"];
    
    self.title = (NSString *)[userInfo objectForKey:@"nickname"];
    [self loadMsgData];
}

- (void) loadMsgData
{
    NSString *url = [NSString stringWithFormat:@"msg/list/%@", (NSString*)[userInfo objectForKey:@"id"]];
    NSDictionary* params = @{};
    [AppSetting httpGet:url parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            NSArray *dataList = (NSArray *)[response objectForKey:@"data"];
            [self renderMsgBox:dataList];
        } else {
            NSLog(@"failed");
        }
    }];
}

- (void) renderMsgBox: (NSArray *)data
{
    for (NSInteger i = 0, l = [data count]; i < l; i++) {
        NSDictionary *chat = (NSDictionary *)[data objectAtIndex:i];
        NSString *posterID = (NSString *)[chat objectForKey:@"poster_id"];
        id <BORChatMessage> message = [[BORChatMessage alloc] init];
        
        message.text = (NSString*)[chat objectForKey:@"content"];
        message.sentByCurrentUser = [posterID isEqualToString:owner_id];
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormater dateFromString: (NSString *)[chat objectForKey:@"created_at"]];
        
        message.date = date;
        [self addMessage:message scrollToMessage:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendMessage {
    id <BORChatMessage> message = [[BORChatMessage alloc] init];
    message.text = self.messageTextView.text;
    message.sentByCurrentUser = YES;
    message.date = [NSDate date];
    [self addMessage:message scrollToMessage:YES];
    [super sendMessage];
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
