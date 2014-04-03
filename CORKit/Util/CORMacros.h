//
//  CORMacros.h
//  COR 
//
//  Created by Seiya Sasaki on 2014/03/24.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

// UIColor short hand
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// thread
#define UA_runOnMainThread if (![NSThread isMainThread]) { dispatch_sync(dispatch_get_main_queue(), ^{ [self performSelector:_cmd]; }); return; };

// string with format
#define NSPRINTF(f, ...) [NSString stringWithFormat:f, __VA_ARGS__]

// get weak reference of self by SELF
#define PREPARE_SELF __weak typeof(self) SELF = self

// debug log
#ifdef DEBUG

#define LOG(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])

#else

#define LOG(...) do { } while (0)

#endif