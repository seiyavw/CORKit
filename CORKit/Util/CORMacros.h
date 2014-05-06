//
//  CORMacros.h
//  COR 
//
//  Created by Seiya Sasaki on 2014/03/24.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

// device info
#define IS_IOS7 floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define SCREEN_HEIGHT = if (IS_IPHONE_5) { return 568.f;} else {return 480.f;}

// UIColor short hand
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// thread
#define RunOnMainThread if (![NSThread isMainThread]) { dispatch_sync(dispatch_get_main_queue(), ^{ [self performSelector:_cmd]; }); return; };

// string with format
#define NSPRINTF(f, ...) [NSString stringWithFormat:f, __VA_ARGS__]

// get weak reference of self by SELF
#define PREPARE_SELF __weak typeof(self) SELF = self

// shows reference count on console
#define LogReferenceCount(obj) NSLog(@"[%@] reference count = %ld", [obj class], CFGetRetainCount((__bridge void*)obj))

// debug log
#ifdef DEBUG

#define LOG(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])

#else

#define LOG(...) do { } while (0)

#endif