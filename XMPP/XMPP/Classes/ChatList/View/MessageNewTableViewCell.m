//
//  MessageNewTableViewCell.m
//  Project
//
//  Created by 超级腕电商 on 16/4/18.
//  Copyright © 2016年 super. All rights reserved.
//

#import "MessageNewTableViewCell.h"
#import "SPMessageLabel.h"

@implementation MessageNewTableViewCell
{
    UIImageView * headPhotoImageView;
    SPMessageLabel * messageLabel;
    UIImageView * picImageView;
    UIImageView * messageBackImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //头像
        headPhotoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:headPhotoImageView];
        
        //背景图
        messageBackImageView = [[UIImageView alloc] init];
        messageBackImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:messageBackImageView];
        
        //信息
        messageLabel = [[SPMessageLabel alloc] init];
        //messageLabel.layer.cornerRadius = 5;
        //messageLabel.layer.masksToBounds = YES;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:13];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.insetRight = 5;
        messageLabel.insetLeft = 5;
        //messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageBackImageView addSubview:messageLabel];
        
        //图片
        picImageView = [[UIImageView alloc] init];
        //picImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //picImageView.layer.borderWidth = 5;
        picImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:picImageView];
        
        __weak typeof(self) __self = self;
        __weak typeof(UIImageView) *__picImageView = picImageView;
        [__picImageView setUserInteractionEnabled:true];
        [__picImageView setTapActionWithBlock:^{
            if ([__self.delegate respondsToSelector:@selector(didTapImageView:imageList:withIndex:)]) {
//                [__self.delegate didTapImageView:__picImageView imageList:@[_message.pic.pic_url] withIndex:0];
            }
        }];
        
        self.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
       
        
        
        
    }
    return self;
}
//-(void)setMessage:(ServerCenterMessage *)message
//{
//    if (_message != message) {
//        _message = message;
//        [self setNeedsLayout];
//    }
//}
-(void)setObject:(XMPPMessageArchiving_Message_CoreDataObject *)object
{
    if (_object!=object) {
        _object = object;
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat messageWidth = screenWidth -120;//
    
    if (_object) {
        NSString * type=[_object.message.body substringToIndex:3];
        NSString * content=[_object.message.body substringFromIndex:3];
        headPhotoImageView.frame =CGRectMake(10, 5, 40, 40);
        [headPhotoImageView setImage:[UIImage imageNamed:@"defaultFrind"]];
        if (self.photoImage) {
            [headPhotoImageView setImage:self.photoImage];
        }
        //文字信息
         messageLabel.text = content;
        CGSize mySize = [messageLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:messageLabel.font,NSFontAttributeName, nil]];
        messageLabel.size = mySize;
        if (mySize.width>messageWidth) {
            mySize.width = messageWidth;
        }
        CGRect contentRect = [messageLabel.text boundingRectWithSize:CGSizeMake(mySize.width, CGFLOAT_MAX)
                                                             options:(NSStringDrawingUsesLineFragmentOrigin)
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}
                                                             context:nil];
        mySize.height = contentRect.size.height +10;
        mySize.width = mySize.width+20;
        messageBackImageView.size = mySize;
        messageBackImageView.top = headPhotoImageView.top;
        messageBackImageView.left = headPhotoImageView.right+5;
        messageLabel.frame = CGRectMake(5, 0, messageBackImageView.width-5, mySize.height);
        
        messageBackImageView.image = [[UIImage imageNamed:@"bubbleReceive"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        
        
        //图片
        //        picImageView.frame =CGRectMake(50, 5, _message.thumb.width/2, _message.thumb.height/2);
        //        [picImageView sd_setImageWithURL:[NSURL URLWithString:_message.thumb.pic_url]];
        
        UIImage *bubble = [[UIImage alloc] init];
        if (!_object.isOutgoing) {
            headPhotoImageView.frame =CGRectMake(10, 5, 40, 40);
            messageBackImageView.image = [[UIImage imageNamed:@"bubbleReceive"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
            messageBackImageView.left = headPhotoImageView.right+5;
            picImageView.left = headPhotoImageView.right+5;
            bubble = [UIImage imageNamed:@"bubbleReceive"];
            messageLabel.textColor = [UIColor whiteColor];
            messageLabel.centerX = messageBackImageView.width/2+5;
        }else
        {
            headPhotoImageView.frame =CGRectMake(screenWidth-45, 5, 40, 40);
            messageBackImageView.image = [[UIImage imageNamed:@"bubbleSender"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
            messageBackImageView.right = headPhotoImageView.left-5;
            picImageView.right = headPhotoImageView.left-5;
            bubble = [UIImage imageNamed:@"bubbleSender"];
            messageLabel.textColor = [UIColor blackColor];
            messageLabel.centerX = messageBackImageView.width/2;
        }
        //气泡效果
        UIImageView *ImageView = [[UIImageView alloc] init];
        
        [ImageView setImage:[bubble stretchableImageWithLeftCapWidth:15 topCapHeight:40]];
        [ImageView setFrame:picImageView.frame];
        
        CALayer *layer              = ImageView.layer;
        layer.frame                 = (CGRect){{0,0},ImageView.layer.frame.size};
        picImageView.layer.mask = layer;
        
        if ([type isEqualToString:MESSAGE_STR])
        {
            picImageView.hidden = YES;
            messageBackImageView.hidden = NO;
        }else if ([type isEqualToString:MESSAGE_IMAGESTR])
        {
            picImageView.hidden = NO;
            messageBackImageView.hidden = YES;
        }
 
    }
    

}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
