//
//  SPImageViewProtocol.h
//  superwan
//
//  Created by Kiefer on 15/4/28.
//  Copyright (c) 2015年 kiefer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPImageViewProtocol <NSObject>

- (void)didTapImageView:(UIImageView *)imageView imageList:(NSArray *)imageList withIndex:(NSInteger)index;

@end
