//
//  SPViewController.m
//  
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "SPViewController.h"

@interface SPViewController ()

@end

@implementation SPViewController

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _naviBackIndex = kNaviStackMax;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.fd_interactivePopDisabled = false;
//    self.fd_prefersNavigationBarHidden = false;
//    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 100.0;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.hidesBackButton = true;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    if ([self.navigationController.viewControllers count] > 1) {
        [self setupBackBarButtonItem];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[SVProgressHUD dismiss];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.navigationItem.title = title;
}

- (void)setupBackBarButtonItem {
    UIImage *image = [UIImage imageNamed:@"navItemBack"];
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemButton setBackgroundColor:[UIColor clearColor]];
    [itemButton setFrame:CGRectMake(0, 0, 44, 44)];
    [itemButton setImage:image forState:UIControlStateNormal];
    [itemButton setImageEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 18)];
    [itemButton addTarget:self action:@selector(_handleViewBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
}

// 关闭输入框
- (void)_handleEndEditing {
    [self.view endEditing:true];
}

// 页面返回事件
- (void)_handleViewBack {
    if ([self.navigationController.viewControllers count] == 1) {
        [self dismissViewControllerAnimated:true completion:^{ }];
        return;
    }
    UIViewController *viewController = [self viewControllerWithNaviIndex:self.naviBackIndex];
    if (viewController) {
        [self.navigationController popToViewController:viewController animated:true];
    } else {
        [self.navigationController popViewControllerAnimated:true];
    }
}

// 从导航栏栈中获取UIViewController
- (UIViewController *)viewControllerWithNaviIndex:(int)naviIndex {
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (naviIndex < [viewControllers count] - 1) {
        return viewControllers[naviIndex];
    }
    if ([viewControllers count] > 2) {
        return viewControllers[[viewControllers count] - 2];
    }
    return nil;
}

#pragma mark - SPViewControllerDelegate
// 交给子类去实现
- (void)loadData {}
- (void)reloadData {}

#pragma mark - UIViewControllerRotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return false;
}

@end
