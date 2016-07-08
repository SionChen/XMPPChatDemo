//
//  GGJRefreshHeader.h
//  superwan
//
//  Created by cyx on 15/7/9.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import "MJRefreshHeader.h"

@interface GGJRefreshHeader : MJRefreshHeader {
    UIActivityIndicatorView *loadingView;
    UILabel *statusLabel;
    UILabel *lastUpdatedTimeLabel;
    UIImageView *arrowView;
    UIImageView * reloadImageView;
}

@property (nonatomic)BOOL imageHidden;
@property (nonatomic,copy)NSString *pullString;

@end
