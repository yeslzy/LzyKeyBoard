//
//  LzyMessageModel.h
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/20.
//  Copyright © 2020 findsoft. All rights reserved.
//



#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,LzyMessageType){
    LzyMessageTypeText = 1,
    LzyMessageTypeImage,//图片
    LzyMessageTypeVoice,//发送语音
    LzyMessageTypeVideo,//视频
    LzyMessageTypeFile,//其他文件
    LzyMessageTypeLBS,//地理位置信息
    LzyMessageTypeEnvelope,//红包
    LzyMessageTypeUnknow,//未知类型
};
typedef NS_ENUM(NSInteger,LzyMessageFrom){
    LzyMessageFromMe = 1,//我发的
    LzyMessageFromOther,//别人发的
};


@interface LzyMessageModel : NSObject

@property(nonatomic,assign) NSInteger msgId;
@property(nonatomic,copy) NSString *msgContent;
@property(nonatomic,copy) NSString *fromUserName;
@property(nonatomic,copy) NSString *fromUserAvatorUrl;

@property(nonatomic,assign) LzyMessageType msgType;
@property(nonatomic,copy) NSString *mediaUrl;
@property(nonatomic,copy) NSString *msgTime;//消息发送时间
@property(nonatomic,copy) NSString *lastMsgTime;//最近一条消息时间
@property(nonatomic,assign) LzyMessageFrom msgFrom;//谁发送的消息
@property(nonatomic,assign) CLLocationCoordinate2D point;//LBS 经纬度坐标




- (CGSize)getContentSize;
- (BOOL)showTimeFlag;
- (NSString*)getRealShowTime;

- (CGFloat)getCellHeight;
@end

NS_ASSUME_NONNULL_END
