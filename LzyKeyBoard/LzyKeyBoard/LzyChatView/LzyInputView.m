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
#define kOriginY VIEW_HEIGHT-MY_CELL_HEIGHT-SAFE_AREA_BOTTOM_HEIGHT

@interface LzyInputView ()<UITextViewDelegate>
@property (nonatomic, assign) CGFloat currentTextH;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) LzyTextView *textView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *voiceBtn;
@property (nonatomic, strong) UIButton *plusBtn;

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
    self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.maxHeight = kMaxHeight;
    self.currentTextH = kBaseLineHeight;
}
- (void)setUpSubviews{
    [self addSubview:self.contentView];
    [self addSubview:self.plusBtn];
    [self addSubview:self.voiceBtn];
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
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.top.equalTo(self).offset(10);
        maker.width.height.mas_equalTo(30);
    }];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.equalTo(self).offset(10);
        maker.right.equalTo(self).offset(-10);
        maker.width.height.mas_equalTo(30);
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
    text = [text stringByTrim];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if ([text isNotBlank]) {
        self.textView.text = nil;
        [self initVars];
        if (self.SendTextBlock) {
            self.SendTextBlock(text);
        }
    }
}
#pragma mark  textView代理和监听
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
- (void)showMoreAction{
    
}
- (void)recordVoiceAction{
    
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
- (UIButton*)voiceBtn{
    if (!_voiceBtn) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceBtn setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
        [_voiceBtn addTarget:self action:@selector(recordVoiceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceBtn;
}
- (UIButton*)plusBtn{
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_plusBtn addTarget:self action:@selector(showMoreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusBtn;
}
@end
