//
//  MyXMPPToll.h
//  WeChat-XMPP
//
//  Created by test on 16/4/21.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMPPFramework.h>
#import <XMPPvCardAvatarModule.h>
#import <XMPPvCardTempModule.h>
#import <XMPPvCardCoreDataStorage.h>


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
 电子名片   实现后xmpp框架会自动向服务器请求用户数据，并保存至沙盒
 */
@property (nonatomic,strong) XMPPvCardTempModule *xmppTemp;

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
