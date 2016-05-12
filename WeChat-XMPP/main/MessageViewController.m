//
//  MessageViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/5/12.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController()
{
    
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation MessageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nofifitCentent:) name:XMPPConnectionNotification object:nil];
     [[MyXMPPToll sharedMyXMPPToll] XMPPUserLogin:nil];
    
}
-(void)nofifitCentent:(NSNotification *)nifi{
    
    int status = [[nifi.userInfo objectForKey:@"status"] intValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (status) {
            case XMPPResultTypeLoginConnect:
                [self.activityView startAnimating];
                break;
            case XMPPResultTypeLoginSuccess:
                [self.activityView stopAnimating];
                [MBProgressHUD showSuccess:@"登陆成功" toView:self.view];
                break;
            case XMPPResultTypeLoginFailure:
                [self.activityView stopAnimating];
                [MBProgressHUD showError:@"登陆失败" toView:self.view];
                break;
            case XMPPResultTypeNetError:
                [self.activityView stopAnimating];
                [MBProgressHUD showError:@"网络连接失败" toView:self.view];
                break;
            default:
                break;
        }
    });
    
}

@end
