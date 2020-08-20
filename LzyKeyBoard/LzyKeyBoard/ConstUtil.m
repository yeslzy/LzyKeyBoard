//
//  ConstUtil.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/19.
//  Copyright © 2020 findsoft. All rights reserved.
//

#import "ConstUtil.h"

@implementation ConstUtil


+(BOOL)isValidateCarNoPrefix:(NSString*)carNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}
+ (CGFloat)getOneRowHeightWithWidth:(CGFloat)width theFont:(UIFont*)font{
    NSString *tempStr = @"apple";
    CGRect rect = [tempStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :font} context:nil];
    return rect.size.height;
}
+ (BOOL)isMutilRowsWithContent:(NSString*)content
                      theWidth:(CGFloat)width
                       theFont:(UIFont*)font{
    BOOL result = NO;
    if ([content isNotBlank]) {
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :font} context:nil];
        CGFloat oneRowHeight = [self getOneRowHeightWithWidth:width theFont:font];
        if (rect.size.height>oneRowHeight) {
            result = YES;
        }
    }
    return result;
}
+ (CGFloat)getContentHeightWithWidth:(CGFloat)width
                             theFont:(UIFont*)font
                          theContent:(NSString*)content{
    CGFloat result = 0;
    if ([content isNotBlank]) {
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :font} context:nil];
        result =  rect.size.height;
    }
    return result;
    
}
+ (CGFloat)getContentHeightWithWidth:(CGFloat)width
                        theAttribute:(NSDictionary*)attribute
                          theContent:(NSString*)content{
    CGFloat result = 0;
    if ([content isNotBlank]) {
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        result =  rect.size.height;
    }
    return result;
    
}
@end
