//
//  NAVStyle.m
//  WeChat-XMPP
//
//  Created by test on 16/4/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import "NAVStyle.h"

@implementation NAVStyle

+(void)setNavStyle{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    navBar.tintColor = [UIColor whiteColor];
    
//    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    muDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    muDic[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [navBar setTitleTextAttributes:muDic];
    /**
     *  设置状态栏颜色
     */
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

@end
