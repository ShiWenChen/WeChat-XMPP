//
//  UserDetailViewController.m
//  WeChat-XMPP
//
//  Created by test on 16/4/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import "UserDetailViewController.h"

#import <XMPPvCardTemp.h>
#import "AlertShow.h"
#import "EditingViewController.h"

@interface UserDetailViewController ()<EditingViewControllerDelegate>
{
    UIImagePickerController *_imagePick ;
}

@end

@implementation UserDetailViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self loadData];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    if (!_imagePick) {
        _imagePick = [[UIImagePickerController alloc] init];
        _imagePick.delegate = self;
    }
    
}
/**
 *  加载数据
 */
-(void)loadData{
    /**
     *  用XMPP的XMPPvCardTemp对象可以直接获取沙盒中数据库的用户的信息
     */
    XMPPvCardTemp *userCard = [MyXMPPToll sharedMyXMPPToll].xmppTemp.myvCardTemp;
    if (userCard.photo) {
        self.headerImage.image = [UIImage imageWithData:userCard.photo];
    }
    self.lbUserNick.text = userCard.nickname;
    
    self.lbUserNumber.text = [UserInfo shareduserInfo].userName;
    /**
     *  公司
     */
    self.lbUserCommper.text = userCard.orgName;
    /**
     *  部门  部门可能有多个，直接获取第一个即可
     */
    if (userCard.orgUnits.count>0) {
        self.lbUserDocuMent.text = userCard.orgUnits[0];
    }
    /**
     *  职位
     */
    self.lbUserWork.text = userCard.title;
    /**
     *  电话 xmpp框架并没有解析，如要使用需自己解析 用note暂代
     */
    self.lbUserPhone.text = userCard.note;
    /**
     *  邮件 xmpp框架并没有解析，如要使用需自己解析
     */
    self.lbUserEmail.text = userCard.mailer;
}

/**
 *  tableViewd点击事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
             [[AlertShow sharedAlertShow] actionSheetShowWithTitle:@"拍照" adbtn2:@"从相册中选择" adblock1:^{
                 myLog(@"拍照");
                 _imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
                 [self presentViewController:_imagePick animated:YES completion:nil];
                 
                 
             } adblock2:^{
                 myLog(@"从相册中选择");
                 _imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                 _imagePick.allowsEditing = YES;
                 [self presentViewController:_imagePick animated:YES completion:nil];
             } adController:self];
            return;
        }
        if (indexPath.row == 2) {
            return;
        }
        
    }
    [self performSegueWithIdentifier:@"EditingViewController" sender:cell];
}
#pragma 拍照代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    if (image) {
        self.headerImage.image = image;
        XMPPvCardTemp *vCard = [MyXMPPToll sharedMyXMPPToll].xmppTemp.myvCardTemp;
        vCard.photo = UIImageJPEGRepresentation(image,0.5);
        /**
         *  更新服务器图片
         */
        [[MyXMPPToll sharedMyXMPPToll].xmppTemp updateMyvCardTemp:vCard];
    }
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id viewControl = segue.destinationViewController;
    if ([viewControl isKindOfClass:[EditingViewController class]]) {
        EditingViewController *editingControl = viewControl;
        editingControl.myDelegate = self;
        editingControl.userDetailTableCell = sender;
        
    }
}
-(void)updateUserInfoToHost{
    
    XMPPvCardTemp *userCard = [MyXMPPToll sharedMyXMPPToll].xmppTemp.myvCardTemp;
    userCard.nickname = self.lbUserNick.text;
    /**
     *  公司
     */
    userCard.orgName = self.lbUserCommper.text;
    /**
     *  部门  部门可能有多个，直接获取第一个即可
     */
    if (userCard.orgUnits.count>0) {
        userCard.orgUnits = @[self.lbUserDocuMent.text];
    }
    /**
     *  职位
     */
    userCard.title = self.lbUserWork.text;
    /**
     *  电话 xmpp框架并没有解析，如要使用需自己解析 用note暂代
     */
    userCard.note = self.lbUserPhone.text;
    /**
     *  邮件 xmpp框架并没有解析，如要使用需自己解析
     */
    userCard.mailer = self.lbUserEmail.text;
    
    [[MyXMPPToll sharedMyXMPPToll].xmppTemp updateMyvCardTemp:userCard];
}

@end
