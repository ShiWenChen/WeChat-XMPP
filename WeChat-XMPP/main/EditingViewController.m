//
//  EditingViewController.m
//  WeChat-XMPP
//
//  Created by test on 16/4/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "EditingViewController.h"
#import <XMPPvCardTemp.h>

@interface EditingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfUserInfoMation;


@end

@implementation EditingViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = _userDetailTableCell.textLabel.text;
    self.tfUserInfoMation.text = self.userDetailTableCell.detailTextLabel.text;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    
    
    
}
/**
 *  保存按钮
 */
-(void)saveAction{
    self.userDetailTableCell.detailTextLabel.text = self.tfUserInfoMation.text;
    

//    vCard.
    if ([self.myDelegate respondsToSelector:@selector(updateUserInfoToHost)]) {
        [self.myDelegate updateUserInfoToHost];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
