//
//  AlertShow.h
//  WeChat-XMPP
//
//  Created by test on 16/4/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^btn1CleckBlock)();
typedef void(^btn2CleckCBlock)();
@interface AlertShow : UIViewController
SingletonH(AlertShow)

-(void)actionSheetShowWithTitle:(NSString *)btnTitle1 adbtn2:(NSString *)btnTitle2 adblock1:(btn1CleckBlock)colmpe1 adblock2:(btn2CleckCBlock)colmpe2 adController:(UIViewController*)controller;




@end
