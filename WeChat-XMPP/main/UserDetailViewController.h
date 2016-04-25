//
//  UserDetailViewController.h
//  WeChat-XMPP
//
//  Created by test on 16/4/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *lbUserNick;
/**
 *  微信号
 */
@property (weak, nonatomic) IBOutlet UILabel *lbUserNumber;
/**
 *  公司
 */
@property (weak, nonatomic) IBOutlet UILabel *lbUserCommper;
/**
 *  部门
 */
@property (weak, nonatomic) IBOutlet UILabel *lbUserDocuMent;
/**
 *  职位
 */
@property (weak, nonatomic) IBOutlet UILabel *lbUserWork;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UILabel *lbUserPhone;
/**
 *  邮件
 */
@property (weak, nonatomic) IBOutlet UILabel *lbUserEmail;

@end
