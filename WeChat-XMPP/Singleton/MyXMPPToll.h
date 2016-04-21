//
//  MyXMPPToll.h
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/21.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMPPFramework.h>


typedef enum{
    XMPPResultTypeLoginSuccess,
    XMPPResultTypeLoginFailure,
    XMPPResultTypeNetError
}XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);

@interface MyXMPPToll : NSObject
SingletonH(MyXMPPToll)

/**
 *  是否是注册，YES为是，NO为否
 */
@property (nonatomic,assign,getter=isRegist) BOOL regist;

/**
 *  注销登录
 */
-(void)XMPPLogOff;
/**
 *  登录
 */
-(void)XMPPUserLogin:(XMPPResultBlock)resultBlock;
/**
 *  注册
 */
-(void)XMPPRegist:(XMPPResultBlock)resultBlock;

@end
