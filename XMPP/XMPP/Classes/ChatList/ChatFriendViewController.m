//
//  ChatFriendViewController.m
//  XMPP
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "ChatFriendViewController.h"
#import "MessageNewTableViewCell.h"
#import "SPImageViewProtocol.h"
#import "SPMessageTableView.h"
#import "IQKeyboardManager.h"
#import "GGJRefreshHeader.h"

@interface ChatFriendViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SPImageViewProtocol,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>


@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIImage * friendPhotoImage;
@property(nonatomic,strong)UIImage * myPhotoImage;
@end

static CGFloat bottomHeight = 40;
@implementation ChatFriendViewController
{
    SPMessageTableView * _tableView;
    UITextField * _inputTextField;
    UIView * bottemBackView;
}

-(void)dealloc
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enableAutoToolbar = YES;
    manager.enable = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.enableAutoToolbar = NO;
    self.title = @"会话";
    self.view.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(keyboardWillHidden:)
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
    [self setUpUI];
    //记录当前我和谁聊天了,所有消息回调,全部从block中读取 包括接受消息
    [[ZCXMPPManager sharedInstance] valuationChatPersonName:self.friendJid IsPush:YES MessageBlock:^(ZCMessageObject *xx) {
        //在这里ZCMessageObject参数无用
        [self loadData];
    }];
    [self loadData];
}
-(void)_handleViewBack
{
    [[ZCXMPPManager sharedInstance] valuationChatPersonName:NONE IsPush:NO MessageBlock:nil];
    [super _handleViewBack];
}
- (void) keyboardWillShown:(NSNotification *) notif
{
    CGFloat curkeyBoardHeight = [[[notif userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    CGRect begin = [[[notif userInfo] objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect end = [[[notif userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    if(begin.size.height>0 && (begin.origin.y-end.origin.y>0)){
        [UIView animateWithDuration:0.3 animations:^{
            _tableView.contentOffset = CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y+curkeyBoardHeight);
            bottemBackView.top -=curkeyBoardHeight;
        }];
    }
    
    
    
}
- (void) keyboardWillHidden:(NSNotification *) notif
{
    
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.contentOffset = CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y-keyboardSize.height);
        bottemBackView.top +=keyboardSize.height;
    }];
    
    
    
}

//初始化视图控件
-(void)setUpUI
{
    CGFloat viewWidth  = screenWidth;
    CGFloat viewHeight = screenHeight - navBarHeight - bottomHeight-statusBarHeight;
    
    
    //self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[SPMessageTableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = false;
    _tableView.showsVerticalScrollIndicator = true;
    _tableView.delaysContentTouches = false;
    _tableView.scrollsToTop = true;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.1;
    _tableView.sectionFooterHeight = 0.0;
    __weak typeof (self) __self = self;
    [_tableView setTapActionWithBlock:^{
        [__self _handleEndEditing];
    }];
    GGJRefreshHeader * tableHeader =[GGJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    tableHeader.pullString = @"下拉加载更多";
    tableHeader.imageHidden = YES;
    _tableView.header = tableHeader;
    [self.view addSubview:_tableView];
    
    bottemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-bottomHeight-navBarHeight-statusBarHeight, screenWidth, bottomHeight)];
    [self.view addSubview:bottemBackView];
    
    //底部输入框
    _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, screenWidth-80, bottomHeight)];
    _inputTextField.backgroundColor = [UIColor whiteColor];
    CGRect frame = [_inputTextField frame];
    frame.size.width = 20.0f;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    _inputTextField.leftViewMode = UITextFieldViewModeAlways;
    _inputTextField.leftView = leftview;
    _inputTextField.delegate = self;
    _inputTextField.returnKeyType = UIReturnKeySend;
    [bottemBackView addSubview:_inputTextField];
    
    //分隔线
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(20, _inputTextField.height - 7, _inputTextField.width-20, 0.5)];
    separatorLine.backgroundColor = [UIColor colorWithHexString:@"2c5561"];
    [_inputTextField addSubview:separatorLine];
    
    //添加照片按钮
    UIButton * addPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addPhotoButton.frame = CGRectMake(screenWidth-81, 0, 80, bottomHeight);
    addPhotoButton.contentMode = UIViewContentModeCenter;
    [addPhotoButton setImage:[UIImage imageNamed:@"addPic"] forState:UIControlStateNormal];
    [addPhotoButton setImage:[UIImage imageNamed:@"addPicSelect"] forState:UIControlStateHighlighted];
    addPhotoButton.backgroundColor = [UIColor whiteColor];
    [addPhotoButton addTarget:self action:@selector(selectImageAction) forControlEvents:UIControlEventTouchUpInside];
    [bottemBackView addSubview:addPhotoButton];
}
-(void)loadMore
{
    
    
    
}

// 选择图片
- (void)selectImageAction {
    [self _handleEndEditing];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"拍照"
                                              otherButtonTitles:@"从手机相册选择", nil];
    [sheet showInView:self.view];
}
-(void)loadData
{
    //读取聊天记录
    NSArray * messageArray=[[ZCXMPPManager sharedInstance] messageRecord];
    
    self.dataArray=[NSMutableArray arrayWithArray:messageArray];
    
    
    //移动tableView
    if (self.dataArray.count) {
        //刷新数据
        [self getVcardMessage];
        [_tableView reloadData];
        
    }
    
}
-(void)getVcardMessage{
    //获得对方Vcard信息
    self.title=[[self.friendJid componentsSeparatedByString:@"@"]firstObject];
    [[ZCXMPPManager sharedInstance] friendsVcard:self.friendJid Block:^(BOOL isOK, XMPPvCardTemp *friendVcard) {
        if (friendVcard.nickname) {
            self.title=UNCODE(friendVcard.nickname);
        }
        //获取头像
        if (friendVcard.photo) {
            UIImage*leftImage=[UIImage imageWithData:friendVcard.photo];
            _friendPhotoImage=leftImage;
            [_tableView reloadData];
            if (self.dataArray.count) {
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            
        }
        
        
    }];
    
    //获取自己的Vcard信息
    
    [[ZCXMPPManager sharedInstance] getMyVcardBlock:^(BOOL isOK, XMPPvCardTemp *myVcard) {
        if (myVcard.photo) {
            UIImage*right=[UIImage imageWithData:myVcard.photo];
            _myPhotoImage=right;
            [_tableView reloadData];
            if (self.dataArray.count) {
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            
        }
    }];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_inputTextField.text.length>0) {
        //[self submitContent:textField.text];
        //发送信息
        [[ZCXMPPManager sharedInstance] sendMessageWithJID:self.friendJid Message:textField.text Type:@"[1]"];
    }
    [self _handleEndEditing];
    textField.text = @"";
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    [tableView setContentOffset:CGPointMake(0, tableView.contentSize.height -tableView.bounds.size.height) animated:YES];
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageNewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageNewTableViewCell"];
    if (cell == nil) {
        cell = [[MessageNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageNewTableViewCell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    XMPPMessageArchiving_Message_CoreDataObject * object =_dataArray[indexPath.row];
    cell.photoImage = object.isOutgoing?_myPhotoImage:_friendPhotoImage;
    cell.object = object;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMPPMessageArchiving_Message_CoreDataObject * object=self.dataArray[indexPath.row];
    NSString * type=[object.message.body substringToIndex:3];
    NSString * content=[object.message.body substringFromIndex:3];
    if ([type isEqualToString:MESSAGE_STR])
    {
        CGFloat messageWidth = screenWidth -120;
        CGSize mySize = [content sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil]];
        if (mySize.width>messageWidth) {
            mySize.width = messageWidth;
        }
        CGRect contentRect = [content boundingRectWithSize:CGSizeMake(mySize.width, CGFLOAT_MAX)
                                                           options:(NSStringDrawingUsesLineFragmentOrigin)
                                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}
                                                           context:nil];
        mySize.height = contentRect.size.height +10;
        return mySize.height+30;
    }

    return 0;
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
