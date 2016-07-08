//
//  GGJRefreshHeader.m
//  superwan
//
//  Created by cyx on 15/7/9.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import "GGJRefreshHeader.h"

@implementation GGJRefreshHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageHidden = YES;//图片默认隐藏
        //图片
        reloadImageView  = [[UIImageView alloc] init];
        reloadImageView.image = [UIImage imageNamed:@"HomoRefresh"];
        [self addSubview:reloadImageView];
        
        //菊花
        loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.hidesWhenStopped = true;
        [self addSubview:loadingView];
        
        //刷新状态
        statusLabel = [[UILabel alloc] init];
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.font = [UIFont systemFontOfSize:12.0];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        statusLabel.textColor = MJColor(55, 55, 55);
        self.pullString = @"下拉刷新";
        statusLabel.text = NSLocalizedString(self.pullString, @"Pull down to refresh status");
        statusLabel.hidden = false;
        [self addSubview:statusLabel];
        
        lastUpdatedTimeLabel = [[UILabel alloc] init];
        lastUpdatedTimeLabel.backgroundColor = [UIColor clearColor];
        lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12.0];
        lastUpdatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        lastUpdatedTimeLabel.textColor = MJColor(55, 55, 55);
        lastUpdatedTimeLabel.text = NSLocalizedString(@"正在加载...", @"Loading Status");
        lastUpdatedTimeLabel.hidden = true;
        [self addSubview:lastUpdatedTimeLabel];
        
        //下拉箭头
        arrowView = [[UIImageView alloc] init];
        arrowView.image = [UIImage imageNamed:@"dragdown"];
        [self addSubview:arrowView];
        
        
    }
    return self;
}

#pragma makr - 重写父类的方法
- (void)placeSubviews
{
    [super placeSubviews];
    
    reloadImageView.hidden = self.imageHidden;
    reloadImageView.frame = CGRectMake(self.mj_w/2-reloadImageView.image.size.width/2, -reloadImageView.image.size.height-30, reloadImageView.image.size.width, reloadImageView.image.size.height);
    
    arrowView.frame = CGRectMake(self.mj_w/2 - 40, self.mj_h - 35, 20, 20);
    loadingView.frame = CGRectMake(self.mj_w/2 - 10, self.mj_h - 48, 20, 20);
    statusLabel.frame = CGRectMake(0, self.mj_h - 35, self.mj_w, 20);
    lastUpdatedTimeLabel.frame = CGRectMake(0, self.mj_h - 28, self.mj_w, 20);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            statusLabel.hidden = true;
            lastUpdatedTimeLabel.hidden = false;
            
            arrowView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                statusLabel.hidden = false;
                lastUpdatedTimeLabel.hidden = true;
                statusLabel.text = NSLocalizedString(_pullString, @"Pull down to refresh status");

                loadingView.alpha = 1.0;
                [loadingView stopAnimating];
                arrowView.hidden = false;
            }];
        } else {
            statusLabel.hidden = false;
            lastUpdatedTimeLabel.hidden = true;
            statusLabel.text = NSLocalizedString(_pullString, @"Pull down to refresh status");

            [loadingView stopAnimating];
            arrowView.hidden = false;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        statusLabel.hidden = false;
        lastUpdatedTimeLabel.hidden = true;
        statusLabel.text = NSLocalizedString(@"释放加载", @"Release to refresh status");

        [loadingView stopAnimating];
        arrowView.hidden = false;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        statusLabel.hidden = true;
        lastUpdatedTimeLabel.hidden = false;
        
        loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [loadingView startAnimating];
        arrowView.hidden = true;
    }
    [self setNeedsLayout];
}

@end
