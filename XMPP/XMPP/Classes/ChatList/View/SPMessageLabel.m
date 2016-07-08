//
//  SPMessageLabel.m
//  Project
//
//  Created by 超级腕电商 on 16/4/18.
//  Copyright © 2016年 super. All rights reserved.
//

#import "SPMessageLabel.h"

@implementation SPMessageLabel


- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {self.insetTop, self.insetLeft, self.insetBottom, self.insetRight};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
