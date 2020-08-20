//
//  LzyKeyBoardView.h
//  LzyKeyBoard
//
//  Created by 李 战阳 on 16/9/8.
//  Copyright © 2016年 findsoft. All rights reserved.
//


#import "ConstUtil.h"


@interface LzyCarIdKeyBoardView : UIView
@property(nonatomic,weak) id<LzyKeyBoardDelegate> delegate;

-(void)showChineseKeyBoard;
-(void)showNumKeyBoard;
@end
