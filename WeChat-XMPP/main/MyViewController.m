//
//  MyViewController.m
//  WeChat-XMPP
//
//  Created by test on 16/4/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MyViewController.h"
#import <XMPPvCardTemp.h>
#import "UserInfo.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *lbUserNick;

@property (weak, nonatomic) IBOutlet UILabel *lbUserNumber;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated{
    /**
     *  用XMPP的XMPPvCardTemp对象可以直接获取沙盒中数据库的用户的信息
     */
    
    myLog(@"%@",[MyXMPPToll sharedMyXMPPToll].xmppTemp.myvCardTemp);
    XMPPvCardTemp *useCard = [MyXMPPToll sharedMyXMPPToll].xmppTemp.myvCardTemp;
    if (useCard.photo) {
        self.headImage.image = [UIImage imageWithData:useCard.photo];
    }
    self.lbUserNick.text = useCard.nickname;
    
    self.lbUserNumber.text = [NSString stringWithFormat:@"微信号:%@",[UserInfo shareduserInfo].userName];
}
/**
 *  注销登录
 */
- (IBAction)logtAction:(id)sender {
    [[MyXMPPToll sharedMyXMPPToll] XMPPLogOff];
    
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
