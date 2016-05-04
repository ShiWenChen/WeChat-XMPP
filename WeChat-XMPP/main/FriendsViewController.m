//
//  FriendsViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/4/27.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "FriendsViewController.h"
#import "MyXMPPToll.h"

@interface FriendsViewController()<NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_resultConextController;
}
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
//     self.friendsData = [context executeFetchRequest:request error:nil];
    
    /**
     执行请求数据，若coadata数据库发生改变，测刷新数据

     */
    _resultConextController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultConextController.delegate = self;
    myLog(@"%@",_resultConextController.fetchedObjects);
    NSError *error;
    [_resultConextController performFetch:&error];
    if (error) {
        myLog(@"%@",error);
    }

    
    
}
/**
 *  caredata数据库代理
 */
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    myLog(@"数据库发生改变");
    [self.tableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellId";
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    XMPPUserCoreDataStorageObject *friends = _resultConextController.fetchedObjects[indexPath.row];
//    myLog(@"nickname%@",friends.nickname);
    
    if (friends.nickname == nil) {
        myCell.textLabel.text = friends.jidStr;
    }else{
        myCell.textLabel.text = friends.nickname;
    }
    switch ([friends.sectionNum intValue]) {
        case 0:
            myCell.detailTextLabel.text = @"在线";
            break;
        case 1:
            myCell.detailTextLabel.text = @"离开";
            break;
        case 2:
            myCell.detailTextLabel.text = @"离线";
            break;
        default:
            break;
    }
    
    return myCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _resultConextController.fetchedObjects.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 *  删除好友
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        myLog(@"删除");
        XMPPUserCoreDataStorageObject *friends = _resultConextController.fetchedObjects[indexPath.row];
        [[MyXMPPToll sharedMyXMPPToll].xmppRoster removeUser:friends.jid];
        
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除好友";
}
@end
