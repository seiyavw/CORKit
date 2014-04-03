//
//  CORApiClient.h
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/03/24.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^CORApiClientCompletion)(NSDictionary *result, NSError *error);

@interface CORApiClient : NSObject

+ (CORApiClient *)sharedClient;

@end
