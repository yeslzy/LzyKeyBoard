//
//  LzyNumberKeyBoardView.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2019/2/20.
//  Copyright © 2019年 findsoft. All rights reserved.
//

#import "LzyNumberKeyBoardView.h"
@interface LzyNumberKeyBoardView()
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UIButton *doneBtn;
@property(nonatomic,strong) UIButton *clearBtn;
@end

@implementation LzyNumberKeyBoardView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.maxWord = MAX_NUMBER;
        CGFloat height = NUMBER_ROW_HEIGHT*5;
        if (IS_IPHONE_X) {
            height +=SAFE_AREA_BOTTOM_HEIGHT;
        }
        self.frame = CGRectMake(0, 0, VIEW_WIDTH, height);
        self.backgroundColor = UIColor.whiteColor;
        [self setupSubViews];
    }
    return self;
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    if (newWindow) {
        [self createNumberKeyboardRandom];
    }else{
        [self destoryNumberKeyboard];
    }
    
}

#pragma mark 其他方法
- (void)setupSubViews{
    [self addSubview:self.topView];
    [self addSubview:self.contentView];
    
    CGFloat y = CGRectGetMaxY(self.topView.frame);
    [self.contentView setFrame:CGRectMake(0, y, VIEW_WIDTH, self.frame.size.height-y)];
}
- (void)createNumberKeyboardRandom{
    NSMutableArray *numberWordArray = [NSMutableArray arrayWithArray:NUMBERS_WORD_ARRAY];
    [self shuffleTheArray:numberWordArray];
    
    CGFloat btn_width = VIEW_WIDTH/COUNT_OF_ROW_NUMBER_WORD;
    for (int i =0; i<numberWordArray.count; i++) {
        int m = i/COUNT_OF_ROW_NUMBER_WORD;
        int n = i%COUNT_OF_ROW_NUMBER_WORD;
        NSString *num = numberWordArray[i];
        CGRect frame = CGRectZero;
        CGFloat y = m*NUMBER_ROW_HEIGHT;
        if (m == 3) {
            
            [self.contentView addSubview:self.doneBtn];
            [self.doneBtn setFrame:CGRectMake(0, y, btn_width, NUMBER_ROW_HEIGHT)];
            
            frame = CGRectMake(btn_width, y, btn_width, NUMBER_ROW_HEIGHT);
            
            [self.contentView addSubview:self.clearBtn];
            [self.clearBtn setFrame:CGRectMake(btn_width*2, y, btn_width, NUMBER_ROW_HEIGHT)];
    
            
        }else{
            frame = CGRectMake(n*btn_width, m*NUMBER_ROW_HEIGHT, btn_width, NUMBER_ROW_HEIGHT);
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:frame];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightBold]];
        [btn setTitle:num forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.darkTextColor forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        if (n == 0) {
            UILabel *horLineLabel = [UILabel new];
            [horLineLabel setFrame:CGRectMake(0,y, VIEW_WIDTH, 1)];
            [horLineLabel setBackgroundColor:[self getColor:@"CDCDCD"]];
            [self.contentView addSubview:horLineLabel];
        }
    }
    for (int k=0; k<COUNT_OF_ROW_NUMBER_WORD; k++) {
        UILabel *verLineLabel = [UILabel new];
        [verLineLabel setFrame:CGRectMake(k*btn_width,0, 1, NUMBER_ROW_HEIGHT*4)];
        [verLineLabel setBackgroundColor:[self getColor:@"CDCDCD"]];
        [self.contentView addSubview:verLineLabel];
    }
    UILabel *horLineLabel = [UILabel new];
    [horLineLabel setFrame:CGRectMake(0,NUMBER_ROW_HEIGHT*4, VIEW_WIDTH, 1)];
    [horLineLabel setBackgroundColor:[self getColor:@"CDCDCD"]];
    [self.contentView addSubview:horLineLabel];
}
- (void)destoryNumberKeyboard{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}
//数组随机排序
- (void)shuffleTheArray:(NSMutableArray*)array{
    for (NSUInteger i = array.count; i > 1; i--) {
        [array exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}
- (void)btnClick:(UIButton*)sender{
    NSString*title=[sender titleForState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkOneBtnClick:)]) {
        [self.delegate checkOneBtnClick:title];
    }
}
- (void)closeKeyboardView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doneBtnClick)]) {
        [self.delegate doneBtnClick];
    }
}
- (void)clearText{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clearBtnClick)]) {
        [self.delegate clearBtnClick];
    }
}

-(UIColor*)getColor:(NSString*)hexColor{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != hexColor)
    {
        NSScanner *scanner = [NSScanner scannerWithString:hexColor];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}
#pragma mark lazy load
- (UIView*)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, NUMBER_ROW_HEIGHT)];
        _topView.backgroundColor = UIColor.whiteColor;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:_topView.bounds];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:UIColor.darkGrayColor];
        [titleLabel setFont:[UIFont systemFontOfSize:18]];
        [titleLabel setText:@"安全键盘"];
        [_topView addSubview:titleLabel];
    }
    return _topView;
}
- (UIView*)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}
- (UIButton*)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setBackgroundColor:[self getColor:@"CDCDCD"]];
        [_doneBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(closeKeyboardView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}
- (UIButton*)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setBackgroundColor:[self getColor:@"CDCDCD"]];
        [_clearBtn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
@end
