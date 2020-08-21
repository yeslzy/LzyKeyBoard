//
//  ChatDemoViewController.m
//  LzyKeyBoard
//
//  Created by 李战阳 on 2020/8/19.
//  Copyright © 2020 findsoft. All rights reserved.
//
#import "ConstUtil.h"
#import "LzyInputView.h"
#import "LzyMessageCell.h"
#import "LzyMessageModel.h"
#import "ChatDemoViewController.h"

@interface ChatDemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) LzyInputView *inputView;
@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSMutableArray<LzyMessageModel*> *resultList;
@end

@implementation ChatDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNoti];
    [self setupSubViews];
    [self initVars];
}
- (void)setupSubViews{
    self.view.backgroundColor = LIGHT_GRAY_BACKGROUND_COLOR;
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.inputView];
    [self.myTableView setFrame:CGRectMake(0, 0, VIEW_WIDTH,CGRectGetHeight(self.view.frame)- CGRectGetHeight(self.inputView.frame))];
}
- (void)addNoti{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChange:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChange:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
- (void)initVars{
    self.resultList = [NSMutableArray array];
    LzyMessageModel *model1 = [LzyMessageModel new];
    model1.msgId = arc4random_uniform(1000)+1;
    model1.msgContent = @"这一期我们来聊一聊几乎每一个中国人都特别喜欢的东西，那就是“红包”。虽然“红包”在英语里是一个新词，但由于这是中国特有的东西，因此它的拼音“Hongbao”已经作为一个英文单词，直接收录到了很多权威的字典中。一起来看看关于“红包”的三种比较流行的说法。";
    model1.msgFrom = LzyMessageFromOther;
    model1.msgTime = @"2020-08-20 13:02:44";
    model1.msgType = LzyMessageTypeText;
    model1.fromUserName = @"Teacher Angela";
    model1.fromUserAvatorUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3253191218,1641977969&fm=26&gp=0.jpg";
    [self.resultList addObject:model1];
    
    LzyMessageModel *model2 = [LzyMessageModel new];
    model2.msgId = arc4random_uniform(1000)+1;
    model2.msgContent = @"你到底收到了多少红包?";
    model2.msgFrom = LzyMessageFromOther;
    model2.msgTime = @"2020-08-20 13:04:36";
    model2.lastMsgTime = model1.msgTime;
    model2.msgType = LzyMessageTypeText;
    model2.fromUserName = @"Teacher Angela";
    model2.fromUserAvatorUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3253191218,1641977969&fm=26&gp=0.jpg";
    [self.resultList addObject:model2];
    
    LzyMessageModel *model3 = [LzyMessageModel new];
    model3.msgId = arc4random_uniform(1000)+1;
    model3.msgFrom = LzyMessageFromOther;
    model3.msgTime = @"2020-08-20 13:05:18";
    model3.lastMsgTime = model2.msgTime;
    model3.msgType = LzyMessageTypeImage;
    model3.fromUserName = @"Teacher Angela";
    model3.mediaUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597921512469&di=5b8b08d0354591ede869bb24894c76b1&imgtype=0&src=http%3A%2F%2Fdpic.tiankong.com%2Fv2%2Fh7%2FQJ6244673401.jpg";
    model3.fromUserAvatorUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3253191218,1641977969&fm=26&gp=0.jpg";
    [self.resultList addObject:model3];
    
    LzyMessageModel *model4 = [LzyMessageModel new];
    model4.msgId = arc4random_uniform(1000)+1;
    model4.msgContent = @"我是刚收到了很多红包,大概有1000元.";
    model4.msgFrom = LzyMessageFromMe;
    model4.msgTime = @"2020-08-20 13:07:36";
    model4.lastMsgTime = model3.msgTime;
    model4.msgType = LzyMessageTypeText;
    model4.fromUserName = @"Me";
    model4.fromUserAvatorUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597922140661&di=3561661fbe1837cdb77a9e8766ecba71&imgtype=0&src=http%3A%2F%2Fimg2.woyaogexing.com%2F2020%2F08%2F16%2F2bb4d2eff3fa4ec292dd6320520b9362%2521400x400.jpeg";
    [self.resultList addObject:model4];
    
    
    LzyMessageModel *model5 = [LzyMessageModel new];
    model5.msgId = arc4random_uniform(1000)+1;
    model5.msgFrom = LzyMessageFromMe;
    model5.msgTime = @"2020-08-20 13:16:03";
    model5.lastMsgTime = model4.msgTime;
    model5.msgType = LzyMessageTypeImage;
    model5.fromUserName = @"Me";
    model5.fromUserAvatorUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597922140661&di=3561661fbe1837cdb77a9e8766ecba71&imgtype=0&src=http%3A%2F%2Fimg2.woyaogexing.com%2F2020%2F08%2F16%2F2bb4d2eff3fa4ec292dd6320520b9362%2521400x400.jpeg";
    model5.mediaUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2966787345,330833184&fm=26&gp=0.jpg";
    [self.resultList addObject:model5];
    
    [self.myTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTableView scrollToBottom];
    });
    
}
#pragma mark 其他方法
- (void)sendText:(NSString*)text{
    self.inputView.top = self.myTableView.bottom;
    self.inputView.height = MY_CELL_HEIGHT;
    LzyMessageModel *lastMsg = [self.resultList lastObject];
    
    
    LzyMessageModel *model = [LzyMessageModel new];
    model.msgId = arc4random_uniform(1000)+1;
    model.msgFrom = LzyMessageFromMe;
    model.msgTime = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    model.lastMsgTime = lastMsg.msgTime;
    model.msgType = LzyMessageTypeText;
    model.msgContent = text;
    model.fromUserName = @"Me";
    model.fromUserAvatorUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597922140661&di=3561661fbe1837cdb77a9e8766ecba71&imgtype=0&src=http%3A%2F%2Fimg2.woyaogexing.com%2F2020%2F08%2F16%2F2bb4d2eff3fa4ec292dd6320520b9362%2521400x400.jpeg";
    [self.resultList addObject:model];
    [self.myTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTableView scrollToBottom];
    });
}
#pragma mark 消息监听
- (void)keyboardDidChange:(NSNotification *)notification{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = notification.name == UIKeyboardWillShowNotification?rect.size.height:0;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
    self.myTableView.height = self.view.height - self.inputView.height;
    self.myTableView.height -=height;
    self.myTableView.contentOffset = CGPointMake(0, self.myTableView.contentSize.height-self.myTableView.height);

    self.inputView.top = self.myTableView.bottom;
    [UIView commitAnimations];
}
#pragma mark tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultList.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LzyMessageModel *model = self.resultList[indexPath.row];
    NSString *cellStr = [LzyMessageCell cellIdentifier];
    LzyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr forIndexPath:indexPath];
    [cell setCellData:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LzyMessageModel *model = self.resultList[indexPath.row];
    return [model getCellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
#pragma mark lazy load
- (LzyInputView*)inputView{
    if (!_inputView) {
        _inputView = [LzyInputView new];
        @weakify(self)
        _inputView.SendTextBlock = ^(NSString*text){
            [weak_self sendText:text];
        };
    }
    return _inputView;
}
- (UITableView*)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = UIColor.clearColor;
        _myTableView.separatorColor = UIColor.clearColor;
        _myTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _myTableView.scrollsToTop = YES;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:LzyMessageCell.class forCellReuseIdentifier:[LzyMessageCell cellIdentifier]];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id obj){
            [self.view endEditing:YES];
        }];
        [_myTableView addGestureRecognizer:tap];
        
    }
    return _myTableView;
}
@end
