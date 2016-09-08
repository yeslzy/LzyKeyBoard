//
//  ViewController.m
//  LzyKeyBoard
//
//  Created by 李 战阳 on 16/9/7.
//  Copyright © 2016年 findsoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //如何使用自定义键盘
    LzyCarIdKeyBoardView*keyboardView=[[LzyCarIdKeyBoardView alloc] init];
    keyboardView.delegate=self;
    self.textField.inputView=keyboardView;//指定textfield的inputview为自定义键盘
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)checkOneBtnClick:(NSString*)word{
    NSString*text=self.textField.text;
    self.textField.text=[NSString stringWithFormat:@"%@%@",text,word];
}
-(void)clearBtnClick{
    NSString*text=self.textField.text;
    if (text.length>0) {
        self.textField.text=[text substringToIndex:text.length-1];
    }
    if(text.length==0){
        LzyCarIdKeyBoardView*view=(LzyCarIdKeyBoardView*)self.textField.inputView;
        [view showChineseKeyBoard];
    }
}
-(void)doneBtnClick{
    [self.textField resignFirstResponder];
}
@end
