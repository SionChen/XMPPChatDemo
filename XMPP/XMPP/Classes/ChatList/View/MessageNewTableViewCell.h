//
//  MessageNewTableViewCell.h
//  Project
//
//  Created by 超级腕电商 on 16/4/18.
//  Copyright © 2016年 super. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPImageViewProtocol.h"



@interface MessageNewTableViewCell : UITableViewCell

@property(nonatomic, weak) id<SPImageViewProtocol> delegate;

@property(nonatomic,strong) XMPPMessageArchiving_Message_CoreDataObject * object;
@property(nonatomic,strong)UIImage * photoImage;

@end
