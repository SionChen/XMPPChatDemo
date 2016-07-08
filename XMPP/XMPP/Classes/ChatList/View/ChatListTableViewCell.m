//
//  ChatListTableViewCell.m
//  XMPP
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "ChatListTableViewCell.h"

@implementation ChatListTableViewCell
{
    UIImageView * headerImage;
    UILabel * nameLabel;
    UILabel * messageLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        headerImage = [[UIImageView alloc] init];
        [self.contentView addSubview:headerImage];
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nameLabel];
        
        messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:messageLabel];
    }
    return self;
}

-(void)setMessage:(NSArray *)message
{
    if (_message!=message) {
        _message = message;
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
//    nameLabel.text = @"程序设计";
//    messageLabel.text = @"你好啊，狗蛋";
    
    [headerImage setImage:[UIImage imageNamed:@"defaultFrind"]];
    nameLabel.text=_message[2];
    messageLabel.text=[_message firstObject];
    
    NSString*type=[[_message firstObject] substringToIndex:3];
    
    if ([type isEqualToString:MESSAGE_STR]) {
        messageLabel.text=[[_message firstObject]substringFromIndex:3];
    }else{
        if ([type isEqualToString:MESSAGE_VOICE]) {
            messageLabel.text=@"[语音]";
        }else{
            if ([type isEqualToString:MESSAGE_IMAGESTR]) {
                messageLabel.text=@"[图片]";
            }else if ([type isEqualToString:MESSAGE_BIGIMAGESTR]){
                messageLabel.text=@"[表情]";
            }else{
                if ([type isEqualToString:MESSAGE_LOCATION]) {
                    messageLabel.text=@"[位置]";
                }else{
                    messageLabel.text=@"[其他]";
                }
                
            }
        }
        
    }
    if ([[_message lastObject]isEqualToString:GROUPCHAT]) {
        //群聊
        
    }else{
        //单聊
        [[ZCXMPPManager sharedInstance] friendsVcard:_message[2]Block:^(BOOL isOK, XMPPvCardTemp *Friend) {
            if (Friend.photo) {
                headerImage.image=[UIImage imageWithData:Friend.photo];
            }
            if (Friend.nickname) {
                nameLabel.text=UNCODE(Friend.nickname);
            }
            
        }];
        
    }
    
    headerImage.frame = CGRectMake(10, 10, 40, 40);
    headerImage.layer.cornerRadius = headerImage.width/2;
    headerImage.layer.masksToBounds = YES;
    nameLabel.frame = CGRectMake(headerImage.right+10, 10, self.width-60-80, 20);
    messageLabel.frame = CGRectMake(nameLabel.left, nameLabel.bottom+10, nameLabel.width, 10);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
