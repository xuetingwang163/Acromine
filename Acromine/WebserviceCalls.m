//
//  WebserviceCalls.m
//  Acromine
//
//  Created by DevanRaju on 08/01/16.
//  Copyright © 2016 First-tek. All rights reserved.
//

#import "WebserviceCalls.h"
#import "Constants.h"

@implementation WebserviceCalls

static NSString* SERVER_URL  = @"";

// creating shared instance as single ton
+ (WebserviceCalls *)sharedInstance
{
    static WebserviceCalls *WebServiceObject = nil;
    static dispatch_once_t serivceToken ;
    dispatch_once(&serivceToken, ^{
        WebServiceObject =[[WebserviceCalls alloc]init];
    });
    return WebServiceObject;
}

+ (void)initialize
{
    if (SERVER_URL.length == 0) {
        SERVER_URL = ACROMINE_URL;
        DebugLog(@"Server URL: %@", SERVER_URL);
    }
}

- (void)getAcromineWithKeyWork:(NSString *)keyWordString SuccessBlock:(tResponseBlock)successBlock failedCallBack:(tFaliureBlock)failureBlock;
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString *urlString = [NSString stringWithFormat:SERVER_URL,keyWordString];
    
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
         successBlock(responseObject);
        
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        failureBlock(error);
    }];
}
@end
