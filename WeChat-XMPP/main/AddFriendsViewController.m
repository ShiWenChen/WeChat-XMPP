//
//  AddFriendsViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/5/3.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "AddFriendsViewController.h"
#import <XMPPJID.h>

@interface AddFriendsViewController()<UITextFieldDelegate>
{
    
}

@end

@implementation AddFriendsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *friendsName = textField.text;
    NSString *friendsStr = [NSString stringWithFormat:@"%@%@",friendsName,DomainName];
    XMPPJID *friendsJid = [XMPPJID jidWithString:friendsStr];
    if ([friendsName isEqualToString:[UserInfo shareduserInfo].userName]) {
        [MBProgressHUD showError:@"不能添加自己为好友"];
        return YES;
    }
    if ([[MyXMPPToll sharedMyXMPPToll].xmppRosterCoreData userExistsWithJID:friendsJid xmppStream:[MyXMPPToll sharedMyXMPPToll].xmppStream]) {
        [MBProgressHUD showError:@"该好友已经添加"];
        return YES;
    }
    /**
     *  添加好友，只需要调用XMPPRoster的 subscrib添加订阅即可
     */
    [[MyXMPPToll sharedMyXMPPToll].xmppRoster subscribePresenceToUser:friendsJid];
    myLog(@"搜索");
    return YES;
}

@end
