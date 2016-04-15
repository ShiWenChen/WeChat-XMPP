//
//  OtherViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/14.
//  Copyright © 2016年 小城生活. All rights reserved.
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
    [MBProgressHUD showMessage:@"登录中..."];
    /**
     *  先归档，然后调用方法
     */
    NSString *user = self.userName.text;
    NSString *pwd = self.userPwd.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user forKey:@"user"];
    [defaults setObject:pwd forKey:@"pwd"];
    /**
     *  更新沙盒数据
     */
    [defaults synchronize];
    __weak typeof(self) mySelf = self;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate userLogin:^(XMPPResultType type) {
        [mySelf loginResult:type];
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
                
                break;
            default:
                break;
        }

    });
}
-(void)showMainView{
    [self dismissViewControllerAnimated:NO completion:nil];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.view.window.rootViewController = storyBoard.instantiateInitialViewController;
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
