//
//  FriendsViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/27.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "FriendsViewController.h"
#import "MyXMPPToll.h"

@interface FriendsViewController()
@property (nonatomic , strong) NSArray *friendsData;

@end

@implementation FriendsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadFriendsAction];
}


/**
 *  从沙盒中获取好友列表
 */
-(void)loadFriendsAction{
    /**
     *  使用CoreData获取数据
     */
    //1.获取上下文，关联到数据库
    NSManagedObjectContext *context = [MyXMPPToll sharedMyXMPPToll].xmppRosterCoreData.mainThreadManagedObjectContext;
    /**
     *  2.查看存取好友列表的信息的是那张表
     */
    //设置请求对象，请求表 XMPPUserCoreDataStorageObject
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    /**
     *  3.设置过滤排序，过滤掉当前登录的用户
     */
    //用谓词过滤
    NSString *jid = [[UserInfo shareduserInfo] userJID];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",jid];
    request.predicate = predicate;
    
    /**
     *  排序
     */
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sort];
    /**
     *  执行请求，获取数据
     */
     self.friendsData = [context executeFetchRequest:request error:nil];
    myLog(@"%@",self.friendsData);
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellId";
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    XMPPUserCoreDataStorageObject *friends = self.friendsData[indexPath.row];
    myCell.textLabel.text = friends.nickname;
    
    
    return myCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendsData.count;
}

@end
