//
//  LzyInputView.h
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/19.
//  Copyright © 2020 findsoft. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface LzyInputView : UIView
@property(nonatomic,copy)void(^SendTextBlock)(NSString*text);

@end

NS_ASSUME_NONNULL_END
