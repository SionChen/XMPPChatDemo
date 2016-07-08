//
//  ChatListViewController.m
//  XMPP
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatListTableViewCell.h"
#import "ChatFriendViewController.h"
#import "ContactViewController.h"
#import "LoginViewController.h"
#import "SPNavigationController.h"


@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@end

@implementation ChatListViewController
{
    UITableView * _tableView;
    NSArray * _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会话列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"moreBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemACtion)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myFriend"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemACtion)];
    
    [self setupUI];
    [self loadData];
    
    //[[ZCXMPPManager sharedInstance] sendMessageWithJID:@"63488508" Message:@"你好啊，狗蛋" Type:@"[1]"];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}
-(void)rightItemACtion
{
    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"注销" message:@"确定注销吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex) {
        return;
    }
    //告知服务器用户下线
    //切断链接
    //删除用户名密码
    [[ZCXMPPManager sharedInstance] disconnect];
    [[DataStore sharedStore] cleanData];
    //初始化登陆界面
    LoginViewController * viewController = [[LoginViewController alloc]init];
    viewController.isPresent = YES;
    viewController.Update = ^(){
        [self loadData];
    };
    SPNavigationController * nav = [[SPNavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:nav animated:YES completion:nil];
    

    
}
-(void)leftItemACtion
{
    ContactViewController * viewController = [[ContactViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDataSource

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatListTableViewCell"];
    if (cell == nil) {
        cell = [[ChatListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatListTableViewCell"];
    }
    cell.message = _dataArray[indexPath.row];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray * array=_dataArray[indexPath.row];
    NSString * jid=array[2];
    
    
    if ([[array lastObject]hasPrefix: GROUPCHAT]) { //群聊
//        GroupChatViewController*vc=[[GroupChatViewController alloc]init];
//        vc.roomJid=jid;
//        vc.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:vc animated:YES];
       
    }else{//单聊
        ChatFriendViewController * viewController=[[ChatFriendViewController alloc]init];
        viewController.friendJid=jid;
        viewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


-(void)loadData
{
    _dataArray= [ZCMessageObject fetchRecentChatByPage:20];
    [_tableView reloadData];
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
