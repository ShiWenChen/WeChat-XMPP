//
//  LoginSuperClass.m
//  WeChat-XMPP
//
//  Created by test on 16/4/20.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LoginSuperClass.h"

@implementation LoginSuperClass


-(void)userLoginAction{
//    [MBProgressHUD showMessage:@"登录中..." toView:self.view];
//    
//    [self.view endEditing:YES];
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    
//    delegate.regist = NO;
//    __weak typeof(self) mySelf = self;
//    [delegate XMPPUserLogin:^(XMPPResultType type) {
//        [mySelf loginResult:type];
//    }];
    [self.view endEditing:YES];
    
    // 登录之前给个提示
    
    [MBProgressHUD showMessage:@"正在登录中..."];
    /**
     *  获取XMPPToll单例
     */
    MyXMPPToll *xmppToll = [MyXMPPToll sharedMyXMPPToll];
    xmppToll.regist = NO;
    __block typeof(self) mySelf = self;
    
    [xmppToll XMPPUserLogin:^(XMPPResultType type) {
        [mySelf loginResult:type];
    }];
}

-(void)loginResult:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                myLog(@"登录成功");
                
                [self showMainView];
                break;
            case XMPPResultTypeLoginFailure:
                myLog(@"登录失败");
                
                [MBProgressHUD showError:@"用户名或者密码不正确" ];
                
                break;
            case XMPPResultTypeNetError:
                [MBProgressHUD showError:@"网络连接失败"];
                myLog(@"登录失败");
                
                break;
            default:
                break;
        }
        
    });
}
-(void)showMainView{
    [UserInfo shareduserInfo].isLogin = @"1";
    [[UserInfo shareduserInfo] saveUserName];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = storyBoard.instantiateInitialViewController;
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)dealloc{
    myLog(@"%@",self);
}
@end
