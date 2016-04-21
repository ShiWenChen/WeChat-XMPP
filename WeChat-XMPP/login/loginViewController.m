//
//  loginViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/18.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.text = [UserInfo shareduserInfo].userName;
}
/**
 *  登陆
 */
- (IBAction)LoginAction:(id)sender {
//    UserInfo *userinfo = [UserInfo shareduserInfo];
//    userinfo.userName = self.userName.text;
//    userinfo.userPwd = self.userPwd.text;
//    [super userLoginAction];
    
    [UserInfo shareduserInfo].userPwd = self.userPwd.text;
    [super userLoginAction];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
