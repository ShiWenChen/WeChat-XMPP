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
    [MBProgressHUD showMessage:@"登录中..."];
    __weak typeof(self) mySelf = self;
    [self.view endEditing:YES];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate XMPPUserLogin:^(XMPPResultType type) {
        [self loginResult:type];
    }];
}

-(void)loginResult:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                myLog(@"登录成功");
                
                [MBProgressHUD showSuccess:@"登录成功"];
                [self showMainView];
                break;
            case XMPPResultTypeLoginFailure:
                myLog(@"登录失败");
                
                [MBProgressHUD showError:@"账号或密码错误"];
                
                break;
            case XMPPResultTypeNetError:
                
                [MBProgressHUD showMessage:@"网络连接失败"];
                myLog(@"登录失败");
                [MBProgressHUD hideHUD];
                
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
