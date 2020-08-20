//
//  LGInputView.m
//  LGApplications
//
//  Created by 李刚 on 2017/8/11.
//  Copyright © 2017年 李刚. All rights reserved.
//
#import "LzyTextView.h"
#import "ConstUtil.h"
#import "LzyInputView.h"

// 默认高度
#define kBaseLineHeight  25
#define kMaxHeight       80
#define kOriginY VIEW_HEIGHT-MY_CELL_HEIGHT-SAFE_AREA_BOTTOM_HEIGHT-GAP

@interface LzyInputView ()<UITextViewDelegate>
@property (nonatomic, assign) CGFloat currentTextH;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) LzyTextView *textView;
@property (nonatomic, strong) UIView *contentView;


@end

@implementation LzyInputView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initVars];
        [self setUpSubviews];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectMake(0,kOriginY , VIEW_WIDTH, MY_CELL_HEIGHT)];
}
- (void)initVars{
    self.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    self.maxHeight = kMaxHeight;
    self.currentTextH = kBaseLineHeight;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
- (void)setUpSubviews{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.textView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker*maker){
        maker.left.equalTo(self).offset(50);
        maker.top.equalTo(self).offset(7);
        maker.bottom.equalTo(self).offset(-7);
        maker.right.equalTo(self).offset(-50);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker*maker){
        maker.left.equalTo(self.contentView).offset(10);
        maker.right.equalTo(self.contentView).offset(-10);
        maker.top.equalTo(self.contentView).offset(4);
        maker.bottom.equalTo(self.contentView).offset(-3);
    }];
}
#pragma mark   其他方法
- (void)adjustHeight:(NSString*)text{
    CGFloat height = [ConstUtil getContentHeightWithWidth:self.textView.width-10 theFont:self.textView.font theContent:text]+5;
    height = MAX(height, kBaseLineHeight);
    CGFloat offset = 0;
    if (self.currentTextH == height || (height > self.maxHeight && self.textView.scrollEnabled == YES)) {
        return;
    }
    else{

        if (height > self.maxHeight) {
            offset =  self.currentTextH - self.maxHeight;
            self.currentTextH = self.maxHeight;
            self.textView.scrollEnabled = YES;
        }else{
            offset = self.currentTextH - height;
            self.currentTextH = height;
            self.textView.scrollEnabled = NO;
        }
    }

    // 改变自身高度 并告诉代理做出相应调整
    [UIView animateWithDuration:0.1 animations:^{
        self.height = self.currentTextH + 25;
        [self setOrigin:CGPointMake(self.origin.x, self.origin.y+offset)];
    }];
}

- (void)sendText:(NSString*)text{
    self.textView.text = nil;
    self.height = MY_CELL_HEIGHT;
    if (self.SendTextBlock) {
        self.SendTextBlock(text);
    }
}
#pragma mark  textView代理和监听
- (void)keyboardWillShow:(NSNotification *)notification{
   

    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];

    [self setOrigin:CGPointMake(self.origin.x, rect.origin.y - self.size.height)];
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    CGFloat yy = kOriginY;
    if (self.currentTextH!=kBaseLineHeight) {
        yy = VIEW_HEIGHT-self.height-GAP;
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [self setOrigin:CGPointMake(self.origin.x, yy)];
    [UIView commitAnimations];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSMutableString *string = [textView.text mutableCopy];
    [string replaceCharactersInRange:range withString:text];

    if ([text isEqualToString:@"\n"]) {
        [self sendText:string];
        return NO;
    }else{
        [self adjustHeight:string];
        return  YES;
    }
}


#pragma mark lazy load
- (UIView*)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = UIColor.whiteColor;
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (LzyTextView*)textView{
    if (!_textView) {
        _textView = [[LzyTextView alloc] initWithFrame:CGRectZero];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.placeHolder = @"说点什么吧";
        _textView.scrollEnabled = NO;
        _textView.textContainerInset = UIEdgeInsetsMake(4, 0,4, 0);
    }
    return _textView;
}
@end
