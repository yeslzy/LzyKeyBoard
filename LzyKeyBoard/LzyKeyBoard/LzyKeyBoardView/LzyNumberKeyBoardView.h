//
//  LzyNumberKeyBoardView.h
//  LzyKeyBoard
//
//  Created by 李战阳 on 2019/2/20.
//  Copyright © 2019年 findsoft. All rights reserved.
//
#import "ConstUtil.h"


NS_ASSUME_NONNULL_BEGIN

@interface LzyNumberKeyBoardView : UIView
@property(nonatomic,assign)  int maxWord;//最大位数，默认6位
@property(nonatomic,weak)  id<LzyKeyBoardDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
