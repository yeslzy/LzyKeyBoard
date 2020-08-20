//
//  LzyInputView.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/19.
//  Copyright © 2020 findsoft. All rights reserved.
//
#import "ConstUtil.h"
#import "LzyTextView.h"

@interface LzyTextView()
@property(nonatomic,strong) UILabel *placeHolderLabel;
@end

@implementation LzyTextView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)setupSubViews{
    self.backgroundColor = UIColor.whiteColor;
    self.font = [UIFont systemFontOfSize:15];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    

    [self addSubview:self.placeHolderLabel];
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(self);
        maker.center.equalTo(self);
        maker.right.equalTo(self);
        maker.height.mas_equalTo(20);
    }];
}
- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
}
#pragma mark 其他方法
- (void)textDidChange{
    self.placeHolderLabel.hidden = self.text.length > 0;
}
#pragma mark lazy load
- (UILabel*)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = UILabel.new;
        _placeHolderLabel.numberOfLines = 1;
        _placeHolderLabel.font = [UIFont systemFontOfSize:14];
        _placeHolderLabel.textColor = [UIColor colorWithHexString:@"#D2D2D2"];
    }
    return _placeHolderLabel;
}
@end
