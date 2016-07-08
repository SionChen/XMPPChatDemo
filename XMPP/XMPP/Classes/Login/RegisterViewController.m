//
//  RegisterViewController.m
//  superwan
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "RegisterViewController.h"
#import "ChatListViewController.h"
#import "SPNavigationController.h"
#import "AlertMessage.h"

@interface RegisterViewController () <UIAlertViewDelegate>
{
    UITextField *usernameField;
    UITextField *passwordField;
    UITextField *passwordField2;

    
}

@property(nonatomic, readonly) UIScrollView *scrollView;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self _handleEndEditing];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

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
    titleLabel.text = @"账号";
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
    titleLabel.text = @"设置密码";
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
    
    tableHeaderY = tableHeaderY + con.height;
    
    con = [[UIView alloc] initWithFrame:CGRectMake(25, tableHeaderY, viewWidth - 25*2, 55)];
    con.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:con];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, con.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithHex:0x282828];
    titleLabel.text = @"确认密码";
    [con addSubview:titleLabel];
    
    passwordField2 = [[UITextField alloc] init];
    passwordField2.backgroundColor = [UIColor clearColor];
    passwordField2.frame = CGRectMake(titleLabel.right, 0, con.width - titleLabel.right - 80, con.height);
    passwordField2.font = [UIFont systemFontOfSize:14.0];
    passwordField2.textColor = [UIColor colorWithHex:0x282828];
    passwordField.secureTextEntry = true;
    passwordField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField2.keyboardType = UIKeyboardTypeASCIICapable;
    [con addSubview:passwordField2];
    
    iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    iconView.frame = CGRectMake(con.width - 80, con.height/2 - 25.0/2, 80, 25);
    iconView.width = iconView.image.size.width;
    iconView.height = iconView.image.size.height;
    iconView.centerX = con.width - 10;
    [con addSubview:iconView];
    

    
    UIImage * image = [UIImage imageWithColor:RGB(3, 3, 3)];
    UIButton *confirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmBtn.frame = CGRectMake(0, viewHeight - 50, viewWidth, 50);
    [confirmBtn setBackgroundImage:image forState:(UIControlStateNormal)];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [confirmBtn setTitle:@"注  册" forState:(UIControlStateNormal)];
    [confirmBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmBtn];
}

- (void)pushToAgreementView {
    
}



// 确定
- (void)confirmBtnAction {
    [self _handleEndEditing];
    
    NSString *username = usernameField.text;
    NSString *password = passwordField.text;
    NSString *password2 = passwordField2.text;
    if (!username || ![username length]) {
        [AlertMessage showMessage:@"账号号不能为空"];
        return;
    }
    if (!password || ![password length]) {
        [AlertMessage showMessage:@"密码不能为空"];
        return;
    }
    if (!password2 || ![password2 length]) {
        [AlertMessage showMessage:@"确认密码不能为空"];
        return;
    }
    
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    [user setObject:usernameField.text forKey:kXMPPmyJID];
    [user setObject:passwordField.text forKey:kXMPPmyPassword];
    [user synchronize];
    
    [SVProgressHUD showWithStatus:@"注册中..." maskType:SVProgressHUDMaskTypeClear];
    [[ZCXMPPManager sharedInstance] registerMothod:^(BOOL isSuccess) {
        if (isSuccess) {
            [SVProgressHUD showWithStatus:@"注册成功，登录中..." maskType:SVProgressHUDMaskTypeClear];;
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
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
        }
    }];

}





////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *  系统-发送短信验证码
 *
 *  @param phone   手机号码
 *  @param sign    验证签名串，全小写
 */
- (void)sendCaptchaByPhone:(NSString *)phone {
    [SVProgressHUD showWithMaskType:(SVProgressHUDMaskTypeClear)];
    [SVProgressHUD showWithStatus:@"发送中..."];
    
    
}

/**
 *  系统-用户注册
 *
 *  @param phone    手机号码
 *  @param pass     登录密码, MD5加密后
 *  @param code     验证码
 *  @param sales_id 邀请码
 *  @param device   设备号，iOS获取设备号，安卓使用个推ClientId
 */
- (void)userRegisterByPhone:(NSString *)phone password:(NSString *)password
                    captcha:(NSString *)captcha inviteCode:(NSString *)inviteCode {
    [SVProgressHUD showWithMaskType:(SVProgressHUDMaskTypeClear)];
    [SVProgressHUD showWithStatus:@"注册中..."];
    
    
}

@end
