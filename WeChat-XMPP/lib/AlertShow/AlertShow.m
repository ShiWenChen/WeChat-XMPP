//
//  AlertShow.m
//  WeChat-XMPP
//
//  Created by test on 16/4/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AlertShow.h"

@implementation AlertShow
SingletonM(AlertShow)


-(void)actionSheetShowWithTitle:(NSString *)btnTitle1 adbtn2:(NSString *)btnTitle2 adblock1:(btn1CleckBlock)colmpe1 adblock2:(btn2CleckCBlock)colmpe2 adController:(UIViewController*)controller{
    NSString *myBtnTitle1 = btnTitle1;
    NSString *myBtnTitle2 = btnTitle2;
    if (myBtnTitle1 == nil) {
        myBtnTitle1 = @"";
    }
    if (myBtnTitle2 == nil) {
        myBtnTitle2 =@"";
    }
    NSString *cacelBtnTitle = @"取消";
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionBtn1 = [UIAlertAction actionWithTitle:myBtnTitle1 style:UIAlertActionStyleDefault handler:colmpe1];
    UIAlertAction *actionBtn2 = [UIAlertAction actionWithTitle:myBtnTitle2 style:UIAlertActionStyleDefault handler:colmpe2];
    UIAlertAction *actionCacelBtn = [UIAlertAction actionWithTitle:cacelBtnTitle style:UIAlertActionStyleCancel handler:nil];
    myLog(@"%@",colmpe1);
    if (btnTitle2 == nil) {
        [alertController addAction:actionBtn1];
    }else if (btnTitle1 == nil){
        [alertController addAction:actionBtn2];
    }else{
        [alertController addAction:actionBtn1];
        [alertController addAction:actionBtn2];
    }
    
    [alertController addAction:actionCacelBtn];
    [controller presentViewController:alertController animated:YES completion:nil];
    
}
@end
