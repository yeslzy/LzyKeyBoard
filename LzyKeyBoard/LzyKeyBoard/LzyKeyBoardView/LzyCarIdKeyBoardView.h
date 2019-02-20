//
//  LzyKeyBoardView.h
//  LzyKeyBoard
//
//  Created by 李 战阳 on 16/9/8.
//  Copyright © 2016年 findsoft. All rights reserved.
//


#import "Constant.h"


@interface LzyCarIdKeyBoardView : UIView
@property(nonatomic,assign)id<LzyCarIdKeyBoardDelegate>delegate;

-(void)showChineseKeyBoard;
-(void)showNumKeyBoard;
+(BOOL)isValidateCarNoPrefix:(NSString*)carNo;
@end
