//
//  UserInfo.h
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/19.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

#define userKey @"user"
#define userLoin @"isLogin"
#define pwd @"pwd"

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
@end
