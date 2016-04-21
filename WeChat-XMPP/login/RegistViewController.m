//
//  RegistViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/21.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "RegistViewController.h"
#import "loginViewController.h"

@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfUserPwd;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation RegistViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
}
/**
 *  注册方法
 */
- (IBAction)registAction {
    if ([self.tfUserPwd.text isEqualToString:@""] || [self.tfUserName.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入用户名或密码" toView:self.view];
        return ;
    }
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"正在注册" toView:self.view];
    /**
     *  存入单例
     */
    [UserInfo shareduserInfo].userRegistName = self.tfUserName.text;
    [UserInfo shareduserInfo].userRegistPwd = self.tfUserPwd.text;
    /**
     *  获取XMPPToll单例
     */
    MyXMPPToll *xmppToll = [MyXMPPToll sharedMyXMPPToll];
    xmppToll.regist = YES;
    
    __weak typeof(self) mySelf = self;
    [xmppToll XMPPRegist:^(XMPPResultType type) {
        myLog(@"%u",type);
        [mySelf registResult:type];
        
    }];
    
}
/**
 *  注册结果处理
 */
-(void)registResult:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                myLog(@"注册成功");
                [UserInfo shareduserInfo].userName = self.tfUserName.text;
//                [[UserInfo shareduserInfo] saveUserName];
                
                if ([self.delegate respondsToSelector:@selector(updateUserName)]) {
                    [self.delegate updateUserName];
                }

                [self backAction:nil];
                break;
            case XMPPResultTypeLoginFailure:
                myLog(@"注册失败");
                
                [MBProgressHUD showError:@"用户名重复" toView:self.view];
                
                break;
            case XMPPResultTypeNetError:
                [MBProgressHUD showError:@"网络连接失败" toView:self.view];
                myLog(@"注册失败");
                [MBProgressHUD hideHUD];
                
                break;
            default:
                break;
        }
        
    });
}
- (IBAction)textFiledChange:(id)sender {
    BOOL enable = (self.tfUserName.text.length > 0 && self.tfUserPwd.text.length > 0);
    self.registBtn.enabled = enable;
}

/**
 *  返回
 */
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
