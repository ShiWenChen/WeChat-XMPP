//
//  loginViewController.m
//  WeChat-XMPP
//
//  Created by test on 16/4/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "loginViewController.h"
#import "RegistViewController.h"

@interface loginViewController ()<RegistViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userPwd.text = @"123456";
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.userName.text = [UserInfo shareduserInfo].userName;
}
/**
 *  登陆
 */
- (IBAction)LoginAction:(id)sender {
    UserInfo *userinfo = [UserInfo shareduserInfo];
    userinfo.userName = self.userName.text;
    userinfo.userPwd = self.userPwd.text;
    [super userLoginAction];
    
//    [UserInfo shareduserInfo].userPwd = self.userPwd.text;
//    [super userLoginAction];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateUserName{
    self.userName.text = [UserInfo shareduserInfo].userName;
    [MBProgressHUD showSuccess:@"请输入密码以登陆" toView:self.view];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    /**
     *  获取控制器
     */
    id viewController = segue.destinationViewController;
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = segue.destinationViewController;
        if ([nav.topViewController isKindOfClass:[RegistViewController class] ]) {
            RegistViewController *registViewControl = (RegistViewController *)nav.topViewController;
            registViewControl.delegate = self;
        }
    }
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
