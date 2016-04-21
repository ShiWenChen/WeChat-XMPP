//
//  AppDelegate.m
//  WeChat-XMPP
//
//  Created by test on 16/4/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AppDelegate.h"

#import "NAVStyle.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NAVStyle setNavStyle];
    [[UserInfo shareduserInfo] readUSerName];
    if ([[UserInfo shareduserInfo].isLogin isEqualToString: @"1"]) {
        [[MyXMPPToll sharedMyXMPPToll] XMPPUserLogin:nil];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.window.rootViewController = storyboard.instantiateInitialViewController;
    }

    
    return YES;
}












@end
