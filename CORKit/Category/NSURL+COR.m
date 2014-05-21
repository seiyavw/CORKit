//
//  NSURL+COR.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/21.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "NSURL+COR.h"

@implementation NSURL (COR)

-(NSDictionary *) dictionaryFromQuery {
    
    NSString *query = [self query];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

@end
