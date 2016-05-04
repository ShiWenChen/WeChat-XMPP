//
//  UserInfo.h
//  WeChat-XMPP
//
//  Created by test on 16/4/19.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

#define userKey @"user"
#define userLoin @"isLogin"
#define pwd @"pwd"
#define DomainName @"wenge.local"
@interface UserInfo : NSObject

SingletonH(userInfo)
/**
 *  用户名
 */
@property (nonatomic,copy) NSString *userName;
/**
 *  密码
 */
@property (nonatomic,copy) NSString *userPwd;
/**
 *  注册用户名
 */
@property (nonatomic,copy) NSString *userRegistName;
/**
 *  注册手机号
 */
@property (nonatomic,copy) NSString *userRegistPwd;

/**
 *  用于判断是否登录 1代表登录，0代表未登录
 */
@property (nonatomic,assign) NSString *isLogin;
/**
 *  保存用户名到沙盒
 */
-(void)saveUserName;
/**
 *  从沙盒中读取用户名
 */
-(void)readUSerName;
/**
 *  获取当前登录用户的JID
 */
-(NSString *)userJID;
@end
