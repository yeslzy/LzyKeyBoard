//
//  LzyMessageContentView.h
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/20.
//  Copyright © 2020 findsoft. All rights reserved.
//  展示具体内容



NS_ASSUME_NONNULL_BEGIN

@interface LzyMessageContentView : UIButton

@property(nonatomic,assign) BOOL messageFromMe;

- (void)setImageContent:(nullable UIImage*)image
            theImageUrl:(nullable NSString *)imgUrl;

- (void)setTextContent:(NSString*)content;


- (void)clearContent;
@end

NS_ASSUME_NONNULL_END
