//
//  AppDelegate.h
//  WeChat-XMPP
//
//  Created by test on 16/4/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    XMPPResultTypeLoginSuccess,
    XMPPResultTypeLoginFailure,
    XMPPResultTypeNetError
}XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  注销登录
 */
-(void)XMPPLogOff;
/**
 *  登录
 */
-(void)XMPPUserLogin:(XMPPResultBlock)resultBlock;


@end

