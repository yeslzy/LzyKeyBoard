//
//  LzyMessageContentView.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/20.
//  Copyright © 2020 findsoft. All rights reserved.
//
#import "ConstUtil.h"
#import "LzyMessageContentView.h"
@interface LzyMessageContentView()

//用于显示图片消息
@property(nonatomic,strong) UIImageView *imgView;

@end


@implementation LzyMessageContentView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    [self.titleLabel setFont:MSG_CELL_CONTENT_FONT];
    [self setBackgroundImage:[UIImage imageNamed:@"bubble_from"] forState:UIControlStateNormal];
    [self addSubview:self.imgView];
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *maker){
        maker.top.equalTo(self);
        maker.right.equalTo(self);
        maker.left.equalTo(self);
        maker.bottom.equalTo(self);
    }];
    
}
- (void)setMessageFromMe:(BOOL)messageFromMe{
    _messageFromMe = messageFromMe;
    UIImage *normal = nil;
    if (_messageFromMe) {
        normal = [UIImage imageNamed:@"bubble_from"];
        self.titleEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 20);
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
     
    }else{
        normal = [UIImage imageNamed:@"bubble_to"];
        self.titleEdgeInsets = UIEdgeInsetsMake(8, 20, 8, 8);
        [self setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    }
    //背景图片拉伸，否则会变形
    CGFloat width = normal.size.width;
    CGFloat height = normal.size.height;
    UIImage *resizableImage = [normal stretchableImageWithLeftCapWidth:width * 0.5 topCapHeight:height * 0.5];
    [self setBackgroundImage:resizableImage forState:UIControlStateNormal];
}
#pragma mark 其他方法
- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}
- (void)setImageContent:(nullable UIImage*)image
            theImageUrl:(nullable NSString *)imgUrl{
    
    self.imgView.hidden = NO;
    if (image) {
        [self.imgView setImage:image];
    }
    if ([imgUrl isNotBlank]) {
        [self.imgView setImageURL:[NSURL URLWithString:imgUrl]];
    }
                
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self makeMaskView:self.imgView withImage:[self backgroundImageForState:UIControlStateNormal]];
    });
    
}
- (void)setTextContent:(NSString*)content{
    
    BOOL flag = [ConstUtil isMutilRowsWithContent:content theWidth:MSG_CELL_MAX_WIDTH-GAP theFont:[UIFont systemFontOfSize:16]];
    if (flag) {
        self.titleLabel.numberOfLines = 0;
    }else{
        self.titleLabel.numberOfLines = 1;
    }
    
    self.imgView.hidden = YES;
    [self setTitle:content forState:UIControlStateNormal];
}

- (void)clearContent{
    [self setTitle:nil forState:UIControlStateNormal];
    [self.imgView setImage:nil];
    self.messageFromMe = NO;
}
#pragma mark lazy load
- (UIImageView*)imgView{
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.layer.cornerRadius = 5;
        _imgView.layer.masksToBounds  = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.hidden = YES;
    }
    return _imgView;
}
@end
