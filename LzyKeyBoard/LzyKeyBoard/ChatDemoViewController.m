//
//  ChatDemoViewController.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/19.
//  Copyright © 2020 findsoft. All rights reserved.
//
#import "ConstUtil.h"
#import "LzyInputView.h"
#import "ChatDemoViewController.h"

@interface ChatDemoViewController ()
@property(nonatomic,strong) LzyInputView *inputView;
@end

@implementation ChatDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}
- (void)setupSubViews{
    self.view.backgroundColor = GRAY_BACKGROUND_COLOR;
    [self.view addSubview:self.inputView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark lazy load
- (LzyInputView*)inputView{
    if (!_inputView) {
        _inputView = [LzyInputView new];
        _inputView.SendTextBlock = ^(NSString*text){
            NSLog(@"text is %@",text);
        };
    }
    return _inputView;
}
@end
