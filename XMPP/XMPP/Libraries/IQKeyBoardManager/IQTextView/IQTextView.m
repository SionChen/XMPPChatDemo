//
//  IQTextView.m
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-15 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "IQTextView.h"

#import <UIKit/UILabel.h>
#import <UIKit/UINibLoading.h>

#if !(__has_feature(objc_instancetype))
    #define instancetype id
#endif

//Xcode 4.5 compatibility check
#ifndef NSFoundationVersionNumber_iOS_5_1
    #define NSLineBreakByWordWrapping UILineBreakModeWordWrap
#endif

@interface IQTextView ()

- (void)refreshPlaceholder;

@end

@implementation IQTextView
{
    UILabel *placeHolderLabel;
}

@synthesize placeholder = _placeholder;

- (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholder) name:UITextViewTextDidChangeNotification object:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)refreshPlaceholder
{
    if ([[self text] length]) {
        [placeHolderLabel setAlpha:0];
    } else {
        [placeHolderLabel setAlpha:1];
    }
    [self layoutIfNeeded];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self refreshPlaceholder];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    placeHolderLabel.font = self.font;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (_placeholderColor != placeholderColor) {
        _placeholderColor = placeholderColor;
        [self setNeedsLayout];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    if (placeHolderLabel == nil) {
        placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.backgroundColor = [UIColor clearColor];
        placeHolderLabel.font = self.font;
        placeHolderLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.alpha = 0;
        [self addSubview:placeHolderLabel];
    }
    placeHolderLabel.text = self.placeholder;
    [self refreshPlaceholder];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    placeHolderLabel.frame = CGRectMake(self.textContainerInset.left + 4, self.textContainerInset.top,
                                        self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - 8,
                                        self.bounds.size.height - self.textContainerInset.top - self.textContainerInset.bottom);
    placeHolderLabel.textColor = self.placeholderColor;
    [placeHolderLabel sizeToFit];
}



//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
- (id<UITextViewDelegate>)delegate
{
    [self refreshPlaceholder];
    return [super delegate];
}

@end
