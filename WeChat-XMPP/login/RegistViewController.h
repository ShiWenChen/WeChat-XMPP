//
//  RegistViewController.h
//  WeChat-XMPP
//
//  Created by test on 16/4/21.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistViewControllerDelegate <NSObject>

-(void)updateUserName;

@end

@interface RegistViewController : UIViewController


@property (nonatomic,assign) id<RegistViewControllerDelegate> delegate;

@end
