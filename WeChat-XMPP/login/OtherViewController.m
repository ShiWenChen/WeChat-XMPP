//
//  OtherViewController.m
//  WeChat-XMPP
//
//  Created by test on 16/4/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OtherViewController.h"
#import "AppDelegate.h"
@interface OtherViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userPwd.text = @"123456";
    self.userName.text = @"zhangsan";
}
/**
 *  登录方法
 */
- (IBAction)LoginAction:(id)sender {
    
    /**
     *  将用户名，密码存入单例
     */
    UserInfo *userinfo = [UserInfo shareduserInfo];
    userinfo.userName = self.userName.text;
    userinfo.userPwd = self.userPwd.text;
    [super userLoginAction];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancleAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc{
    myLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
