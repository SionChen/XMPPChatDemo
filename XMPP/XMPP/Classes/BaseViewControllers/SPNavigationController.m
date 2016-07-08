//
//  SPNavigationController.m
//  
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "SPNavigationController.h"


@interface SPNavigationController ()

@end

@implementation SPNavigationController

- (void)dealloc {
    //DBLOG(@"[%@ dealloc]", [self class]);
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_fullscreenPopGestureRecognizer.enabled = true;
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = true;
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:40/255.f green:42/255.f blue:44/255.f alpha:1.f];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = false;
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.navigationBar setTitleTextAttributes:titleTextAttributes];
}

#pragma mark - UIViewControllerRotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return false;
}

@end
