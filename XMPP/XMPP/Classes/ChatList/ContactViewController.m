//
//  ContactViewController.m
//  XMPP
//
//  Created by 超级腕电商 on 16/7/8.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "ContactViewController.h"
#import "ChatFriendViewController.h"
#import "ContectTableViewCell.h"
#import "VerifyViewController.h"

@interface ContactViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@end

@implementation ContactViewController
{
    UITableView * _tableView;
    NSArray * _dataArray;
    //显示验证消息数量
    UIButton * checkButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"好友列表";
    [self setupUI];
    [self loadData];
}
-(void)setupUI
{
    CGFloat viewWidth  = screenWidth;
    CGFloat viewHeight = screenHeight-navBarHeight-statusBarHeight-tabBarHeight;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = false;
    _tableView.showsVerticalScrollIndicator = true;
    _tableView.delaysContentTouches = false;
    _tableView.scrollsToTop = true;
    _tableView.tableHeaderView.height = 0.0;
    [self.view addSubview:_tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
}
-(void)rightBarButtonAction
{
    //添加好友
    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"请输入好友账号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alertView.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alertView show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex) {
        return;
    }
    UITextField*textField=[alertView textFieldAtIndex:0];
    [SVProgressHUD showWithStatus:@"发送中..." maskType:SVProgressHUDMaskTypeClear];
    if (textField.text.length>0) {
        //开始发送好友请求  2个参数 第一个是好友账号 第二个是验证消息
        [[ZCXMPPManager sharedInstance] addSomeBody:textField.text Newmessage:[NSString stringWithFormat:@"%@请求添加你为好友",[[NSUserDefaults standardUserDefaults] objectForKey:kXMPPmyJID]]];
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [SVProgressHUD showSuccessWithStatus:@"发送请求成功"];
            [ZCMessageObject fetchRecentChatByPage:20];
            [self loadData];
        });
    }
    
}
#pragma mark UITableViewDataSource

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ContectTableViewCell"];
    if (cell == nil) {
        cell = [[ContectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContectTableViewCell"];
    }
    cell.object = (XMPPUserCoreDataStorageObject *)_dataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    XMPPUserCoreDataStorageObject * object = (XMPPUserCoreDataStorageObject *)_dataArray[indexPath.row];
    

    ChatFriendViewController * viewController=[[ChatFriendViewController alloc]init];
    viewController.friendJid=object.jidStr;
    viewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        XMPPUserCoreDataStorageObject * object = (XMPPUserCoreDataStorageObject *)_dataArray[indexPath.row];
        NSString * jString = [[object.jidStr componentsSeparatedByString:@"@"] firstObject];
        [[ZCXMPPManager sharedInstance] removeBuddy:jString];
        [SVProgressHUD showWithStatus:@"删除中..." maskType:SVProgressHUDMaskTypeClear];
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [ZCMessageObject fetchRecentChatByPage:20];
            [self loadData];
        });
        
        
    }];
    
    return @[deleteRowAction];
}
-(void)loadData
{
    
    _dataArray = [[ZCXMPPManager sharedInstance] friendsList:^(BOOL success) {
        if (success) {
            [self loadData];
        }
    }];
    if ([ZCXMPPManager sharedInstance].subscribeArray.count>0) {
        if (checkButton==nil) {
            checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
            checkButton.frame = CGRectMake(0, 0, WIDTH, 40);
            [checkButton addTarget:self action:@selector(checkClick) forControlEvents:UIControlEventTouchUpInside];
            [checkButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            checkButton.titleLabel.font = [UIFont systemFontOfSize:13];
            _tableView.tableHeaderView=checkButton;
        }
        
        [checkButton setTitle:[NSString stringWithFormat:@"当前有%ld条验证消息",[ZCXMPPManager sharedInstance].subscribeArray.count] forState:UIControlStateNormal];
        if (_tableView.tableHeaderView==nil) {
            _tableView.tableHeaderView=checkButton;
        }
        _tableView.contentInset =  UIEdgeInsetsMake(0, 0, 0, 0);
    }else {
        _tableView.contentInset =  UIEdgeInsetsMake(-35, 0, 0, 0);
        _tableView.tableHeaderView= nil;
    }
    
    [_tableView reloadData];
}
-(void)checkClick
{
    VerifyViewController *viewController = [[VerifyViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
