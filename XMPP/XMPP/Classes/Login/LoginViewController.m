//
//  LoginViewController.m
//  XMPP
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ChatListViewController.h"
#import "SPNavigationController.h"

@interface LoginViewController ()

@property(nonatomic, readonly) UIScrollView *scrollView;
@end


@implementation LoginViewController
{
    UITextField *usernameField;
    UITextField *passwordField;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登陆";
    self.navigationController.navigationBar.translucent = YES;
    [self setupUI];
    
    [self tryAutoLogin];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
}
// 初始化视图
- (void)setupUI
{
    CGFloat viewWidth  = screenWidth;
    CGFloat viewHeight = screenHeight - statusBarHeight - navBarHeight;
    CGFloat tableHeaderY = 0.0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.showsVerticalScrollIndicator = false;
    _scrollView.delaysContentTouches = false;
    _scrollView.alwaysBounceVertical = true;
    _scrollView.scrollsToTop = true;
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_scrollView];
    
    UIImageView *topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qr_back"]];
    topImgView.frame = CGRectMake(0, tableHeaderY, viewWidth, viewWidth * 336.0/640);
    [_scrollView addSubview:topImgView];
    
    tableHeaderY = tableHeaderY + topImgView.height;
    
    UIView *con = [[UIView alloc] initWithFrame:CGRectMake(25, tableHeaderY, viewWidth - 25*2, 55)];
    con.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:con];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, con.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithHex:0x282828];
    titleLabel.text = @"账   号";
    [con addSubview:titleLabel];
    
    usernameField = [[UITextField alloc] init];
    usernameField.backgroundColor = [UIColor clearColor];
    usernameField.frame = CGRectMake(titleLabel.right, 0, con.width - titleLabel.right - 20, con.height);
    usernameField.font = [UIFont systemFontOfSize:14.0];
    usernameField.textColor = [UIColor colorWithHex:0x282828];
    usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameField.keyboardType = UIKeyboardTypeNumberPad;
    [con addSubview:usernameField];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobilephone"]];
    iconView.width = iconView.image.size.width;
    iconView.height = iconView.image.size.height;
    iconView.centerX = con.width - 10;
    iconView.centerY = con.height/2;
    [con addSubview:iconView];
    
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, con.height - 0.5, con.width, 0.5)];
    separatorLine.backgroundColor = [UIColor colorWithHex:0xdcdcdc];
    [con addSubview:separatorLine];
    
    tableHeaderY = tableHeaderY + con.height;
    
    con = [[UIView alloc] initWithFrame:CGRectMake(25, tableHeaderY, viewWidth - 25*2, 55)];
    con.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:con];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, con.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithHex:0x282828];
    titleLabel.text = @"密   码";
    [con addSubview:titleLabel];
    
    passwordField = [[UITextField alloc] init];
    passwordField.backgroundColor = [UIColor clearColor];
    passwordField.frame = CGRectMake(titleLabel.right, 0, con.width - titleLabel.right - 20, con.height);
    passwordField.font = [UIFont systemFontOfSize:14.0];
    passwordField.textColor = [UIColor colorWithHex:0x282828];
    passwordField.secureTextEntry = true;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    [con addSubview:passwordField];
    
    iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    iconView.width = iconView.image.size.width;
    iconView.height = iconView.image.size.height;
    iconView.centerX = con.width - 10;
    iconView.centerY = con.height/2;
    [con addSubview:iconView];
    
    separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, con.height - 0.5, con.width, 0.5)];
    separatorLine.backgroundColor = [UIColor colorWithHex:0xdcdcdc];
    [con addSubview:separatorLine];
    
    tableHeaderY = tableHeaderY + con.height + 20;
    
    UIImage *image = [UIImage imageWithColor:RGB(3, 3, 3)];
    UIButton *loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    loginBtn.frame = CGRectMake(25, tableHeaderY, viewWidth - 25*2, 35);
    [loginBtn setBackgroundImage:image forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_scrollView addSubview:loginBtn];
    
    tableHeaderY = tableHeaderY + loginBtn.height + 5;
    
    UIButton *forgotpwdBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    forgotpwdBtn.frame = CGRectMake(25, tableHeaderY, 56, 38);
    [forgotpwdBtn setTitleColor:[UIColor colorWithHex:0x282828] forState:(UIControlStateNormal)];
    [forgotpwdBtn setTitle:@"找回密码" forState:(UIControlStateNormal)];
    [forgotpwdBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    forgotpwdBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2);
    [forgotpwdBtn addTarget:self action:@selector(forgotpwdBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_scrollView addSubview:forgotpwdBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    registerBtn.frame = CGRectMake(viewWidth - 25 - 56, tableHeaderY, 56, 38);
    [registerBtn setTitleColor:[UIColor colorWithHex:0x282828] forState:(UIControlStateNormal)];
    [registerBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    registerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, -14);
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_scrollView addSubview:registerBtn];
}

//自动登录
- (void)tryAutoLogin
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if ([[user stringForKey:kXMPPmyJID] length]>0&&[user stringForKey:kXMPPmyPassword].length>0) {
        [SVProgressHUD showWithStatus:@"登陆中..." maskType:SVProgressHUDMaskTypeClear];
        [[ZCXMPPManager sharedInstance] connectLogin:^(BOOL isSuccess) {
            if (isSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                ChatListViewController * viewController = [[ChatListViewController alloc] init];
                SPNavigationController * nav = [[SPNavigationController alloc] initWithRootViewController:viewController];
                //[self.navigationController pushViewController:viewController animated:YES];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"登陆失败"];
            }
        }];
    }
    
}
// 登录
- (void)loginBtnAction
{
    [self _handleEndEditing];
    
    if (usernameField.text.length>0&&passwordField.text>0) {
        
        NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
        [user setObject:usernameField.text forKey:kXMPPmyJID];
        [user setObject:passwordField.text forKey:kXMPPmyPassword];
        [user synchronize];
        
        [SVProgressHUD showWithStatus:@"登陆中..." maskType:SVProgressHUDMaskTypeClear];
        [[ZCXMPPManager sharedInstance] connectLogin:^(BOOL isSuccess) {
            if (isSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                if (self.isPresent) {
                    self.Update();
                    [self dismissViewControllerAnimated:YES completion:nil];
                    return ;
                }
                ChatListViewController * viewController = [[ChatListViewController alloc] init];
                SPNavigationController * nav = [[SPNavigationController alloc] initWithRootViewController:viewController];
                //[self.navigationController pushViewController:viewController animated:YES];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;

            }else
            {
                [SVProgressHUD showErrorWithStatus:@"登陆失败"];
            }
        }];
    }
    
    
}

// 注册
- (void)registerBtnAction
{
    [self _handleEndEditing];
    RegisterViewController * viewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    return;
    
    
}

// 忘记密码
- (void)forgotpwdBtnAction
{
    [self _handleEndEditing];
    

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
