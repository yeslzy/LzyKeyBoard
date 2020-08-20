//
//  LzyInputView.h
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/19.
//  Copyright © 2020 findsoft. All rights reserved.
//  带提示语的textview

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LzyTextView : UITextView
@property(nonatomic,copy) NSString *placeHolder;

@end

NS_ASSUME_NONNULL_END
