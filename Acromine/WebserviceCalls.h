//
//  WebserviceCalls.h
//  Acromine
//
//  Created by DevanRaju on 08/01/16.
//  Copyright © 2016 First-tek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^tResponseBlock)(id responseObject);
typedef void(^tFaliureBlock) (NSError *error);

@interface WebserviceCalls : NSObject

@property(nonatomic,strong)AFHTTPSessionManager *manager;

+ (WebserviceCalls *)sharedInstance;

- (void)getAcromineWithKeyWork:(NSString *)keyWordString SuccessBlock:(tResponseBlock)successBlock failedCallBack:(tFaliureBlock)failureBlock;

@end
