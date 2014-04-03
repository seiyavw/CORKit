//
//  CORApiClient.m
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/03/24.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "CORApiClient.h"

@implementation CORApiClient
{
    AFHTTPRequestOperationManager *_manager;
}

static NSString *const kCORAPIBaseURL = @"http://dummy.com/api";

+ (CORApiClient *)sharedClient
{
    static dispatch_once_t once;
    static CORApiClient *sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
    
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kCORAPIBaseURL]];
    }
    return self;
}

- (void)getMethodExampleWithParams:(NSString *)paramString paramInt:(NSInteger)paramInt completion:(CORApiClientCompletion)completion
{
    NSDictionary *parameters = @{
                                 @"string": paramString,
                                 @"int"   : @(paramInt)
                                 };
    [_manager GET:kCORAPIBaseURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSString *status = responseDictionary[@"status"];
        
        // check if the status is sent correctly as the request is done succeCORfully
        if (status) {
            
            completion(responseDictionary, nil);
        
        } else {
            
            // needs to define some error object
            completion(responseDictionary, [NSError new]);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        completion(nil, error);
        
    }];
}

@end
