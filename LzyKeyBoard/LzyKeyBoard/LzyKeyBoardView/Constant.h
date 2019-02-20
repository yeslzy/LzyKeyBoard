//
//  Constant.h
//  LzyKeyBoard
//
//  Created by 李 战阳 on 16/9/8.
//  Copyright © 2016年 findsoft. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Constant_h
#define Constant_h
#define GRAY_BACKGROUND_COLOR [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]
#define VIEW_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define VIEW_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define COUNT_OF_ROW_CHINESE_WORD 8//每行显示8个汉字
#define COUNT_OF_ROW_NUM_WORD 10//每行显示10个数字(车牌号键盘)
#define COUNT_OF_ROW_NUMBER_WORD 3//每行显示3个数字(数字键盘)
#define MAX_NUMBER 6//最多输入6位(数字键盘)
#define WORD_HOR_GAP 3//每个字之间的间隔
#define WIDTH_RATIO(w) w*SCREEN_WIDTH/375
#define HEIGHT_RATIO(h) h*SCREEN_HEIGHT/667
#define IS_IPHONE_X  VIEW_WIDTH == 375 && VIEW_HEIGHT >= 812
#define SAFE_AREA_BOTTOM_HEIGHT (IS_IPHONE_X ? 34:0)
#define NAV_BAR_HEIGHT  (IS_IPHONE_X ? 88:64)
#define STATUS_BAR_HEIGHT (IS_IPHONE_X? 44:20)
#define NUMBER_ROW_HEIGHT 44


#define CHINESE_WORD_ARRAY  @[@"京",@"沪",@"浙",@"苏",@"粤",@"鲁",@"晋",@"冀",@"豫",@"川",@"渝",@"辽",@"吉",@"黑",@"皖",@"鄂",@"湘",@"赣",@"闽",@"陕",@"甘",@"宁",@"蒙",@"津",@"贵",@"云",@"桂",@"琼",@"青",@"新",@"藏"]
#define NUMBERS_WORD_ARRAY @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]
#define LETTERS_ARRAY @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]


@protocol LzyCarIdKeyBoardDelegate<NSObject>
-(void)checkOneBtnClick:(NSString*)word;
-(void)clearBtnClick;
-(void)doneBtnClick;

@end

#endif /* Constant_h */
