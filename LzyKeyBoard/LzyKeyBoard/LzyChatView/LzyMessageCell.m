//
//  LzyMessageCell.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/20.
//  Copyright © 2020 findsoft. All rights reserved.
//
#import "LzyMessageModel.h"
#import "ConstUtil.h"
#import "LzyMessageContentView.h"
#import "LzyMessageCell.h"

@interface LzyMessageCell()

@property(nonatomic,strong) UILabel *dateLabel;
@property(nonatomic,strong) UILabel *nickNameLabel;
@property(nonatomic,strong) UIImageView *avatorImgView;
@property(nonatomic,strong) LzyMessageContentView *msgContentView;
@property(nonatomic,strong) LzyMessageModel *msgModel;

@end

@implementation LzyMessageCell

+ (NSString *)cellIdentifier{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)prepareForReuse{
    [super prepareForReuse];
    self.dateLabel.text = nil;
    self.avatorImgView.image = nil;
    self.nickNameLabel.text = nil;
    [self.msgContentView clearContent];
}
- (void)setupSubViews{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.avatorImgView];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.msgContentView];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.right.equalTo(self.contentView);
        maker.top.equalTo(self.contentView).offset(8);
        maker.height.mas_equalTo(LEFT_GAP);
    }];
}

- (void)setCellData:(LzyMessageModel*)model{
    self.msgModel = model;
    self.dateLabel.text = [model getRealShowTime];
    self.dateLabel.hidden = ![model showTimeFlag];
    self.nickNameLabel.text = model.fromUserName;
    [self.avatorImgView setImageWithURL:[NSURL URLWithString:model.fromUserAvatorUrl] placeholder:[UIImage imageNamed:@"avator"]];
    [self.msgContentView setMessageFromMe:model.msgFrom == LzyMessageFromMe];
    
    switch (model.msgType) {
        case LzyMessageTypeImage:{
            [self.msgContentView setImageContent:nil theImageUrl:model.mediaUrl];
        }
            break;
        case LzyMessageTypeText:{
            [self.msgContentView setTextContent:model.msgContent];
        }
            break;
        default:
            break;
    }
    
    CGSize size = [model getContentSize];
    
    if (model.msgFrom == LzyMessageFromOther) {
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.avatorImgView mas_remakeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.contentView).offset(10);
            maker.top.equalTo(self.dateLabel.mas_bottom).offset(10);
            maker.width.height.mas_equalTo(40);
        }];
        
        [self.nickNameLabel mas_remakeConstraints:^(MASConstraintMaker *maker){
            maker.top.equalTo(self.dateLabel.mas_bottom).offset(8);
            maker.left.equalTo(self.avatorImgView.mas_right).offset(10);
            maker.width.mas_equalTo(200);
            maker.height.mas_equalTo(LEFT_GAP);
        }];
        [self.msgContentView mas_remakeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.avatorImgView.mas_right).offset(10);
            maker.top.equalTo(self.dateLabel.mas_bottom).offset(25);
            maker.width.mas_equalTo(size.width);
            maker.height.mas_equalTo(size.height);
        }];
        
    }else{
        self.nickNameLabel.textAlignment = NSTextAlignmentRight;
        
        [self.avatorImgView mas_remakeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(self.contentView).offset(-10);
            maker.top.equalTo(self.dateLabel.mas_bottom).offset(10);
            maker.width.height.mas_equalTo(40);
        }];
        [self.nickNameLabel mas_remakeConstraints:^(MASConstraintMaker *maker){
            maker.top.equalTo(self.dateLabel.mas_bottom).offset(8);
            maker.right.equalTo(self.avatorImgView.mas_left).offset(-10);
            maker.width.mas_equalTo(200);
            maker.height.mas_equalTo(LEFT_GAP);
        }];
        [self.msgContentView mas_remakeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(self.avatorImgView.mas_left).offset(-10);
            maker.top.equalTo(self.dateLabel.mas_bottom).offset(25);
            maker.width.mas_equalTo(size.width);
            maker.height.mas_equalTo(size.height);
        }];
        
    }
}


#pragma mark lazy load
- (UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:11];
        _dateLabel.textColor = UIColor.lightGrayColor;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}
- (UILabel*)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.textColor = UIColor.lightGrayColor;
        _nickNameLabel.font = [UIFont systemFontOfSize:11];
    }
    return _nickNameLabel;
}
- (UIImageView*)avatorImgView{
    if (!_avatorImgView) {
        _avatorImgView = UIImageView.new;
        _avatorImgView.layer.cornerRadius = 20;
        _avatorImgView.layer.masksToBounds = YES;
    }
    return _avatorImgView;
}

- (LzyMessageContentView*)msgContentView{
    if (!_msgContentView) {
        _msgContentView = [[LzyMessageContentView alloc] init];
    }
    return _msgContentView;
}
@end
