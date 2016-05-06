//
//  ChactViewController.m
//  WeChat-XMPP
//
//  Created by 小城生活 on 16/5/4.
//  Copyright © 2016年 小城生活. All rights reserved.
//

#import "ChactViewController.h"
#import <XMPPMessage.h>

@interface ChactViewController()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
    if (indexLast.row >0) {
        [self.tableView scrollToRowAtIndexPath:indexLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"ChatCellId";
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (myCell==nil) {
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    myCell.textLabel.numberOfLines = 1000;
    myCell.textLabel.textAlignment = NSTextAlignmentJustified;
    XMPPMessageArchiving_Message_CoreDataObject *message = _resultsController.fetchedObjects[indexPath.row];
    /**
     *  获取消息类型
     */
    NSString *messageType = [message.message attributeStringValueForName:@"bodyType"];
    myLog(@"%@",messageType);
    
    if ([messageType isEqualToString:@"image"]) {
        myLog(@"消息类型为图片");
        NSData *dataImage = [[NSData alloc] initWithBase64EncodedString:message.body options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:dataImage];
        myCell.imageView.image = image;
        return myCell;

    }else if ([messageType isEqualToString:@"avi"]){
        myLog(@"消息类型为音频");
        return myCell;
    }else{
        if ([message.outgoing boolValue]) {
            myCell.textLabel.text = [NSString stringWithFormat:@"me:%@",message.body];
        }else{
            if (message.body == nil) {
                myCell.textLabel.text = @"输入中";
            }else{
                myCell.textLabel.text = [NSString stringWithFormat:@"you:%@",message.body];
            }
            
        }
        return myCell;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsController.fetchedObjects.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XMPPMessageArchiving_Message_CoreDataObject *message = _resultsController.fetchedObjects[indexPath.row];
    /**
     *  获取消息类型
     */
    NSString *messageType = [message.message attributeStringValueForName:@"bodyType"];
    if ([messageType isEqualToString:@"image"]) {
        return 80;
        
    }else if ([messageType isEqualToString:@"avi"]){
        myLog(@"消息类型为音频");
        return 40;
    }else{

        UIFont *font = [UIFont systemFontOfSize:14];
        CGRect rect = [message.body boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        return rect.size.height+20;
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    NSString *messageStr = textView.text;
    if ([messageStr rangeOfString:@"\n"].length != 0) {
        myLog(@"发送消息");
        /**
         *  去除换行字符
         */
        messageStr = [messageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self sendMessage:messageStr ad:@"text"];
        textView.text = @"";
        
    }
}
/**
 *  发送消息
 * 若要发送图片，有两种方式，一种是讲图片转为二进制data，然后以base64作为加密方式，转化为字符串，让后作为body发送，该方法传送数据不易过大。另一种是将图片先发送给服务器，然后，让服务器返回图片地址，及类型，然后再显示地址图片即可，一般用后一种。
 */
-(void)sendMessage:(NSString *)text ad:(NSString *)type{
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.friendsJid];
    
    [message addAttributeWithName:@"bodyType" stringValue:type];
    [message addBody:text];
    [[MyXMPPToll sharedMyXMPPToll].xmppStream sendElement:message];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 *  发送图片消息
 */
- (IBAction)sendImageAction {
    UIImagePickerController *imagePickControl = [[UIImagePickerController alloc] init];
    imagePickControl.delegate = self;
    imagePickControl.allowsEditing = YES;
    imagePickControl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickControl animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    myLog(@"%@",[info allKeys]);
    UIImage *choseImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *dataImage = UIImageJPEGRepresentation(choseImage, 0.8);
    NSString *imageDataStr = [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    myLog(@"%@",imageDataStr);
    [self sendMessage:imageDataStr ad:@"image"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
