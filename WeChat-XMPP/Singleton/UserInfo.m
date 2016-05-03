//
//  UserInfo.m
//  WeChat-XMPP
//
//  Created by test on 16/4/19.
//  Copyright © 2016年 test. All rights reserved.
//

#import "UserInfo.h"



@implementation UserInfo
SingletonM(userInfo)

-(void)saveUserName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userName forKey:userKey];
    [defaults setObject:self.isLogin forKey:userLoin];
    [defaults setObject:self.userPwd forKey:pwd];
    
    
}
-(void)readUSerName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userName = [defaults objectForKey:userKey];
    self.isLogin = [defaults objectForKey:userLoin];
    self.userPwd = [defaults objectForKey:pwd];
}
-(NSString *)userJID{
    return [NSString stringWithFormat:@"%@@%@",self.userName,DomainName];
}
@end
