//
//  MyXMPPToll.m
//  WeChat-XMPP
//
//  Created by test on 16/4/21.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MyXMPPToll.h"
#import "AppDelegate.h"

@interface MyXMPPToll ()<XMPPStreamDelegate>
{
    /**
     *  xmpp数据流
     */
    XMPPStream *_xmppStream;
    XMPPResultBlock _resultBlock;
    
    /**
     xmpp用于存储数据的类
     */
    XMPPvCardCoreDataStorage *_xmppCoreData;
    /**
     xmpp头像模块
     */
    XMPPvCardAvatarModule *_xmppvCard;
    /**
     自动连接模块
     */
    XMPPReconnect *_xmppReconnect;
    
}



/**
 *  1 初始化XMPPStream
 */
-(void)initXMPPStream;
/**
 * 2 连接到服务器
 */
-(void)connectHost;
/**
 * 3 连接成功，发送密码
 */
-(void)sendPwd;
/**
 *  4 登陆成功，告诉服务器，用户在线
 */
-(void)sendOnlenHost;
/**
 *  注销清理内存释放内存方法
 */
-(void)releaseMemory;

@end

@implementation MyXMPPToll
SingletonM(MyXMPPToll)

#pragma mark 内部方法
/**
 *  初始化XMPPStream
 */
-(void)initXMPPStream{
    myLog(@"实例化Stream");
    /**
     实例化Stream
     */
    _xmppStream = [[XMPPStream alloc] init];
    /**
     *  创建电子名片模块
     */
    _xmppCoreData = [XMPPvCardCoreDataStorage sharedInstance];
    self.xmppTemp = [[XMPPvCardTempModule alloc] initWithvCardStorage:_xmppCoreData];
    /**
     *  激活xmpptemp
     */
    [_xmppTemp activate:_xmppStream];
    /**
     通过电子名片实例化头像模块
     */
    _xmppvCard = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:self.xmppTemp ];
    /**
     *  激活头像模块
     */
    [_xmppvCard activate:_xmppStream];
    
    /**
     花名册模块
     */
    _xmppRosterCoreData = [[XMPPRosterCoreDataStorage alloc] init];
    _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterCoreData];
    /**
     *  激活花名册模块
     */
    [_xmppRoster activate:_xmppStream];
    
    
    
    
    /**
     自动连接模块
     */
    _xmppReconnect = [[XMPPReconnect alloc] init];
    [_xmppReconnect activate:_xmppStream];
    
    /**
     *  设置代理 队列为全局默认队列
     */
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}
/**
 *  释放内存 移除代理
 */
-(void)releaseMemory{
    /**
     *  移除代理
     */
    [_xmppStream removeDelegate:self];
    /**
     *  停止模块
     */
    [_xmppReconnect deactivate];
    [_xmppTemp deactivate];
    [_xmppvCard deactivate];
    [_xmppRoster deactivate];
    
    /**
     *  断开连接
     */
    [_xmppStream disconnect];
    /**
     *  清空资源
     */
    _xmppReconnect = nil;
    _xmppStream = nil;
    _xmppvCard = nil;
    _xmppTemp = nil;
    _xmppCoreData = nil;
    _xmppRoster = nil;
    _xmppRosterCoreData = nil;
    
}
#pragma mark 连接服务器
-(void)connectHost{
    myLog(@"开始连接服务器");
    if (!_xmppStream) {
        [self initXMPPStream];
    }
    
    /**
     *  设置用户的JID（用户名) domain：域名 resource为设备标示
     */
    NSString *user;
    if (self.isRegist) {
        myLog(@"注册");
        user = [UserInfo shareduserInfo].userRegistName;
    }else{
        user = [UserInfo shareduserInfo].userName;
    }
    
    
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"wenge.local" resource:@"iPhone"];
    _xmppStream.myJID = myJID;
    /**
     *  服务器ip地址
     */
    _xmppStream.hostName = @"192.168.1.155";
    /**
     *  设置服务器端口号
     */
    _xmppStream.hostPort = 5222;
    NSError *error = nil;
    
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        myLog(@"%@",error);
    }
    
    
}
-(void)sendPwd{
    NSError *error = nil;
    NSString *userPwd;
    if (self.isRegist) {
        userPwd = [UserInfo shareduserInfo].userRegistPwd;
        [_xmppStream registerWithPassword:userPwd error:&error];
    }else{
        userPwd= [UserInfo shareduserInfo].userPwd;
        [_xmppStream authenticateWithPassword:userPwd error:&error];
    }
    
    
    if (error) {
        myLog(@"%@",error);
    }
}
/**
 *  告诉服务器该用户在线
 */
-(void)sendOnlenHost{
    /**
     * 告诉服务器当前用户在线
     */
    myLog(@" 告诉服务器当前用户在线");
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

#pragma mark xmpp代理方法
/**
 *  链接成功进入
 */
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    myLog(@"连接成功%@",sender);
    
    [self sendPwd];
    
}
/**
 *  链接失败进入
 */
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    myLog(@"与主机断开连接%@",error);
    if (error && _resultBlock) {
        _resultBlock(XMPPResultTypeNetError);
    }
}
/**
 *  密码正确，验证成功
 *
 *  @param sender
 */
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    myLog(@"授权成功");
    [self sendOnlenHost];
    
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    myLog(@"授权失败");
    
    if (_resultBlock) {
        
        _resultBlock(XMPPResultTypeLoginFailure);
    }
    
    
}




/**
 *  注册代理方法
 */
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    myLog(@"注册成功");
    _resultBlock(XMPPResultTypeLoginSuccess);
    
}

-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    myLog(@"注册失败%@",error);
    
    _resultBlock(XMPPResultTypeLoginFailure);
}
#pragma mark --公共方法
/**
 *  用户登录方法
 */
-(void)XMPPUserLogin:(XMPPResultBlock)resultBlock{
    [_xmppStream disconnect];
    _resultBlock = resultBlock;
    [self connectHost];
}
/**
 *  注册
 */
-(void)XMPPRegist:(XMPPResultBlock)resultBlock{
    [_xmppStream disconnect];
    _resultBlock = resultBlock;
    [self connectHost];
}
/**
 *  注销登录
 */
-(void)XMPPLogOff{
    /**
     *  告诉服务器离线
     */

    XMPPPresence *disConnect = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:disConnect];
    /**
     *  断开连接
     */
    [_xmppStream disconnect];
    [self releaseMemory];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:[NSBundle mainBundle]];
    [UIApplication sharedApplication].keyWindow.rootViewController = [storyboard instantiateInitialViewController];
    
}

@end
