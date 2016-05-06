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
#import <XMPPReconnect.h>
#import <XMPPRoster.h>
#import <XMPPRosterCoreDataStorage.h>
#import <XMPPMessageArchiving.h>
#import <XMPPMessageArchivingCoreDataStorage.h>



typedef enum{
    XMPPResultTypeLoginSuccess,
    XMPPResultTypeLoginFailure,
    XMPPResultTypeNetError
}XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);

@interface MyXMPPToll : NSObject
SingletonH(MyXMPPToll)

/**
 *  xmpp数据流
 */
@property(nonatomic,strong) XMPPStream *xmppStream;
/**
 *  是否是注册，YES为是，NO为否
 */
@property (nonatomic,assign,getter=isRegist) BOOL regist;
/**
 电子名片   实现后xmpp框架会自动向服务器请求用户数据，并保存至沙盒
 */
@property (nonatomic,strong) XMPPvCardTempModule *xmppTemp;

/**
 *  花名册模块(好友)
 *
 *  @return 和电子名片一样，只用将XMPPRoster模块添加即可，自动获取好友并且报讯在以XMPPRosterCoreDataStorage保存在沙盒中
 */
@property (nonatomic,strong) XMPPRoster *xmppRoster;
@property (nonatomic,strong) XMPPRosterCoreDataStorage *xmppRosterCoreData;
/**
 聊天模块
 */
@property (nonatomic , strong) XMPPMessageArchiving *xmppMessage;
@property (nonatomic , strong) XMPPMessageArchivingCoreDataStorage *xmppMessageData;

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
