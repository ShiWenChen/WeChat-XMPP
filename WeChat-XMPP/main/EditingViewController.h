//
//  EditingViewController.h
//  WeChat-XMPP
//
//  Created by test on 16/4/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EditingViewControllerDelegate <NSObject>

-(void)updateUserInfoToHost;

@end
@interface EditingViewController : UITableViewController
@property (nonatomic,strong) UITableViewCell *userDetailTableCell;
@property (nonatomic,assign) id <EditingViewControllerDelegate>myDelegate;


@end
