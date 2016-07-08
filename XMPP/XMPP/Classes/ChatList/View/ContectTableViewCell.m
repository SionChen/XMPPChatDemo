//
//  ContectTableViewCell.m
//  XMPP
//
//  Created by 超级腕电商 on 16/7/8.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "ContectTableViewCell.h"

@implementation ContectTableViewCell
{
    UIImageView * headerImage;
    UILabel * nameLabel;
    UILabel * signLabel;
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
        
        signLabel = [[UILabel alloc] init];
        signLabel.textColor = [UIColor lightGrayColor];
        signLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:signLabel];
    }
    return self;
}

-(void)setObject:(XMPPUserCoreDataStorageObject *)object
{
    if (_object!=object) {
        _object = object;
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString * jString = [[_object.jidStr componentsSeparatedByString:@"@"] firstObject];
    //给默认头像
    headerImage.image=[UIImage imageNamed:@"defaultFrind"];
    //给默认账号显示
    nameLabel.text=jString;
    //给默认签名
    signLabel.text=@"这家伙很懒,没有签名";
    //获取头像,昵称,签名
    [[ZCXMPPManager sharedInstance] friendsVcard:jString Block:^(BOOL isVard, XMPPvCardTemp *friend) {
        //判断当前cell的用户名是否是和我通过block返回的是一致的
        if ([jString isEqualToString:friend.jid.user]) {
            //可以进行赋值
            //头像
            if (friend.photo) {
                headerImage.image=[UIImage imageWithData:friend.photo];
            }
            if (friend.nickname) {
                nameLabel.text=UNCODE(friend.nickname);
            }
            NSString * sign=[[friend elementForName:QMD]stringValue];
            if (sign) {
                signLabel.text=UNCODE(sign);
            }
            
        }else{
            //否则抛弃
            
        }
        
    }];
    
    headerImage.frame = CGRectMake(10, 10, 40, 40);
    headerImage.layer.cornerRadius = headerImage.width/2;
    headerImage.layer.masksToBounds = YES;
    nameLabel.frame = CGRectMake(headerImage.right+10, 10, self.width-60-80, 20);
    signLabel.frame = CGRectMake(nameLabel.left, nameLabel.bottom+10, nameLabel.width, 10);
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
