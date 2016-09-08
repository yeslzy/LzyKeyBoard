//
//  ViewController.h
//  LzyKeyBoard
//
//  Created by 李 战阳 on 16/9/7.
//  Copyright © 2016年 findsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzyCarIdKeyBoardView.h"
@interface ViewController : UIViewController<UITextFieldDelegate,LzyCarIdKeyBoardDelegate>
@property(nonatomic,weak)IBOutlet UITextField*textField;
@end

