//
//  ChactViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/5/4.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "ChactViewController.h"
#import <XMPPMessage.h>

@interface ChactViewController()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate,UITextViewDelegate>
{
    /**
     *  查询对象
     */
    NSFetchedResultsController *_resultsController;
    
}

@property (nonatomic,weak)IBOutlet UITextView *tvInput;
@property (nonatomic,weak)IBOutlet UIButton *btnVoic;
@property (nonatomic,weak)IBOutlet UIButton *btnExperian;
@property (nonatomic,weak)IBOutlet UIButton *btnOther;
@property (nonatomic,weak)IBOutlet UIView *inputVeiw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBordViewbottom;
@property (nonatomic,weak)IBOutlet UITableView *tableView;


@end

@implementation ChactViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = self.friendsJid.user;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChang:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self loadMessageData];

}
-(void)keyboardWillChang:(NSNotification *)notifi{
    //    NSLog(@"%@",notifi);
    CGFloat windH = [UIScreen mainScreen].bounds.size.height;
    CGRect keyCgrect = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyViewH = keyCgrect.origin.y;
    self.keyBordViewbottom.constant = windH - keyViewH;
    myLog(@"%f",self.keyBordViewbottom.constant);
    [self tableViewScrollLast];
    
}
/**
 *  加载两天信息
 */
-(void)loadMessageData{
    /**
     *  获取上下文
     */
    NSManagedObjectContext *context = [MyXMPPToll sharedMyXMPPToll].xmppMessageData.mainThreadManagedObjectContext;
    /**
     *  设置请求对象
     */
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    /**
     *  过滤：1、过滤登陆用户的JID的消息 2、好友的Jid的消息
     *   streamBareJidStr为表中当前登陆用户的JID  bareJidStr为好友的JID
     */
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[UserInfo shareduserInfo].userJID,self.friendsJid.bare];
    request.predicate = pre;
    /**
     *  排序方式为时间升序
     */
    NSSortDescriptor *timeUP = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[timeUP];
    
    /**
     *  查询
     */
    /**
     实例化查询对象 传入查询请求和查询上下文
     */
    _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultsController.delegate = self;
    NSError *error;
    if (![_resultsController performFetch:&error]) {
        myLog(@"%@",error);
    }
    [self tableViewScrollLast];
    
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
    [self tableViewScrollLast];
}
/**
 *  tableview自动滚动
 */
-(void)tableViewScrollLast{
    NSIndexPath *indexLast = [NSIndexPath indexPathForRow:_resultsController.fetchedObjects.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"ChatCellId";
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (myCell==nil) {
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    XMPPMessageArchiving_Message_CoreDataObject *message = _resultsController.fetchedObjects[indexPath.row];
    
    if ([message.outgoing boolValue]) {
        myCell.textLabel.text = [NSString stringWithFormat:@"me:%@",message.body];
    }else{
        if (message.body == nil) {
            myCell.textLabel.text = @"。。。";
        }else{
            myCell.textLabel.text = [NSString stringWithFormat:@"you:%@",message.body];
        }
        
    }
    
    return myCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsController.fetchedObjects.count;
}
-(void)textViewDidChange:(UITextView *)textView{
    NSString *messageStr = textView.text;
    if ([messageStr rangeOfString:@"\n"].length != 0) {
        myLog(@"发送消息");
        [self sendMessage:messageStr];
        textView.text = @"";
        
    }
}
/**
 *  发送消息
 */
-(void)sendMessage:(NSString *)text{
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.friendsJid];
    [message addBody:text];
    [[MyXMPPToll sharedMyXMPPToll].xmppStream sendElement:message];
}

@end
