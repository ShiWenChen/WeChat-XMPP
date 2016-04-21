//
//  AppDelegate.h
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/13.
//  Copyright © 2016年 小城生活. All rights reserved.
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

