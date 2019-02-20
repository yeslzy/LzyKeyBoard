//
//  ViewController.m
//  LzyKeyBoard
//
//  Created by 李 战阳 on 16/9/7.
//  Copyright © 2016年 findsoft. All rights reserved.
//
#import "LzyCarIdKeyBoardView.h"
#import "LzyNumberKeyBoardView.h"
#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate,LzyCarIdKeyBoardDelegate>
@property(nonatomic,strong) LzyCarIdKeyBoardView*carKeyboardView;
@property(nonatomic,strong) LzyNumberKeyBoardView *numberKeyboardView;
@property(nonatomic,assign) BOOL flag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //如何使用自定义键盘
   //self.textField.inputView = self.carKeyboardView;
   self.textField.inputView = self.numberKeyboardView;
   self.flag = YES;
    
   if (self.flag) {
       [self.textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark 代理方法
-(void)checkOneBtnClick:(NSString*)word{
    NSString *text=self.textField.text;
    NSString *newText = [NSString stringWithFormat:@"%@%@",text,word];
    self.textField.text = nil;
    [self.textField insertText:newText];
}
-(void)clearBtnClick{
    NSString*text=self.textField.text;
    if (text.length>0) {
        text = [text substringToIndex:text.length-1];
        self.textField.text = nil;
        [self.textField insertText:text];
    }
    if(text.length==0){
        if ([self.textField.inputView isKindOfClass:LzyCarIdKeyBoardView.class]) {
            LzyCarIdKeyBoardView*view=(LzyCarIdKeyBoardView*)self.textField.inputView;
            [view showChineseKeyBoard];
        }
    }
}
-(void)doneBtnClick{
    [self.textField resignFirstResponder];
}
- (void)textFieldTextChange:(UITextField*)textField{
    NSString *text = textField.text;
    if (text.length==self.numberKeyboardView.maxWord) {
        [self.textField resignFirstResponder];
    }
}
#pragma mark lazy load
- (LzyCarIdKeyBoardView*)carKeyboardView{
    if (!_carKeyboardView) {
        _carKeyboardView = [LzyCarIdKeyBoardView new];
        _carKeyboardView.delegate = self;
    }
    return _carKeyboardView;
}
- (LzyNumberKeyBoardView*)numberKeyboardView{
    if (!_numberKeyboardView) {
        _numberKeyboardView = [LzyNumberKeyBoardView new];
        _numberKeyboardView.delegate = self;
    }
    return _numberKeyboardView;
}
@end
