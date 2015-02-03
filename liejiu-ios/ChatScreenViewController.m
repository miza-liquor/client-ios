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
    NSString *ownerID;
    NSString *lastChatID;
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
    ownerID = (NSString *)[owner objectForKey:@"id"];
    lastChatID = @"0";
    
    self.title = (NSString *)[userInfo objectForKey:@"nickname"];
    [self loadMsgData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void) loadMsgData
{
    NSString *url = [NSString stringWithFormat:@"msg/list/%@?last_id=%@", (NSString*)[userInfo objectForKey:@"id"], lastChatID];
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
    for (NSInteger i = [data count] - 1; i >= 0; i--) {
        NSDictionary *chat = (NSDictionary *)[data objectAtIndex:i];
        NSString *posterID = (NSString *)[chat objectForKey:@"poster_id"];
        id <BORChatMessage> message = [[BORChatMessage alloc] init];
        
        message.text = (NSString*)[chat objectForKey:@"content"];
        message.sentByCurrentUser = [posterID isEqualToString:ownerID];
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormater dateFromString: (NSString *)[chat objectForKey:@"created_at"]];
        lastChatID = (NSString *)[chat objectForKey:@"id"];
        
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
//    id <BORChatMessage> message = [[BORChatMessage alloc] init];
//    message.text = self.messageTextView.text;
//    message.sentByCurrentUser = YES;
//    message.date = [NSDate date];
//    [self addMessage:message scrollToMessage:YES];
    
    NSDictionary *params = @{
                                @"recipient_id": (NSString *)[userInfo objectForKey:@"id"],
                                @"content":self.messageTextView.text,
                                @"last_id": lastChatID
                            };
    [AppSetting httpPost:@"post/msg" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            NSArray *dataList = (NSArray *)[response objectForKey:@"data"];
            [self renderMsgBox:dataList];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
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

- (IBAction)onClickRefrehBtn:(id)sender
{
    [self loadMsgData];
}
@end
