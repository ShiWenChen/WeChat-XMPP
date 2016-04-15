//
//  MyViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/15.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  注销登录
 */
- (IBAction)logtAction:(id)sender {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate XMPPLogOff];
    
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
