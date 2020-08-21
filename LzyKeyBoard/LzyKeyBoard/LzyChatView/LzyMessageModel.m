//
//  LzyMessageModel.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/20.
//  Copyright © 2020 findsoft. All rights reserved.
//
#import "ConstUtil.h"
#import "LzyMessageModel.h"

@implementation LzyMessageModel


- (CGSize)getContentSize{
    CGSize size = CGSizeZero;
    switch (self.msgType) {
        case LzyMessageTypeText:{
            CGFloat height = [ConstUtil getContentHeightWithWidth:MSG_CELL_MAX_WIDTH-GAP theFont:[UIFont systemFontOfSize:16] theContent:self.msgContent];
            if (height>20) {//多行
                size = CGSizeMake(MSG_CELL_MAX_WIDTH, height+20);
            }else{
                CGFloat width = [self.msgContent widthForFont:[UIFont systemFontOfSize:16]];
                size = CGSizeMake(width+GAP*2,40);
            }
        }
            break;
        case LzyMessageTypeImage:{
            size = CGSizeMake(MSG_CELL_MAX_WIDTH*0.5, 100);
        }
            break;
        case LzyMessageTypeLBS:{
            size = CGSizeMake(MSG_CELL_MAX_WIDTH*0.7, 120);
        }
            break;
        case LzyMessageTypeFile:{
            size = CGSizeMake(MSG_CELL_MAX_WIDTH*0.7, 90);
        }
            break;
        default:
            size = CGSizeMake(100, 30);
            break;
    }
    return size;
}
- (BOOL)showTimeFlag{
    if (!self.lastMsgTime) {
        return YES;
    }
    NSDate *date1 = [NSDate dateWithString:self.msgTime format:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [NSDate dateWithString:self.lastMsgTime format:@"yyyy-MM-dd HH:mm:ss"];
    
    NSInteger year1 = date1.year;
    NSInteger year2 = date2.year;
    if (year1 == year2) {
        NSInteger month1 = date1.month;
        NSInteger month2 = date2.month;
        if (month1 == month2) {
            NSInteger day1 = date1.day;
            NSInteger day2 = date2.day;
            if (day1 == day2) {
                NSInteger hour1 = date1.hour;
                NSInteger hour2 = date2.hour;
                if (hour1 == hour2) {
                    NSInteger minute1 = date1.minute;
                    NSInteger minute2 = date2.minute;
                    if (minute1 - minute2>5) {
                        return YES;
                    }else{//上下两条消息不超过5分钟,则不显示时间
                        return NO;
                    }
                }else{//不在同一小时
                    return YES;
                }
            }else{//不在同一天
                return YES;
            }
            
        }else{//不在同一月
            return YES;
        }
    }else{//消息和上一条消息时间不在同一年
        return YES;
    }
}
- (NSString*)getRealShowTime{
    NSDate *date1 = [NSDate dateWithString:self.msgTime format:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [NSDate date];
    if (date1.year == date2.year) {
        if (date1.month == date2.month) {
            if (date1.day == date2.day) {
                return [date1 stringWithFormat:@"HH:mm"];
            }else{
                return [date1 stringWithFormat:@"MM月dd日 HH:mm"];
            }
        }else{
            return [date1 stringWithFormat:@"MM月dd日 HH:mm"];
        }
    }else{
        return [date1 stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
}
- (CGFloat)getCellHeight{
    CGSize size = [self getContentSize];
    CGFloat tHeight = self.showTimeFlag?20:8;
    CGFloat height = tHeight+size.height+GAP*3;
    return height;
}
@end
