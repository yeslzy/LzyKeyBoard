//
//  LzyMessageCell.h
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/20.
//  Copyright © 2020 findsoft. All rights reserved.
//

@class LzyMessageModel;

NS_ASSUME_NONNULL_BEGIN

@interface LzyMessageCell : UITableViewCell

+ (NSString *)cellIdentifier;

- (void)setCellData:(LzyMessageModel*)msgModel;
@end

NS_ASSUME_NONNULL_END
