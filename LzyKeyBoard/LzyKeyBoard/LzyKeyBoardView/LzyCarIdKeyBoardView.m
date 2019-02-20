//
//  LzyKeyBoardView.m
//  LzyKeyBoard
//
//  Created by 李 战阳 on 16/9/8.
//  Copyright © 2016年 findsoft. All rights reserved.
//
//

#import "LzyCarIdKeyBoardView.h"
@implementation LzyCarIdKeyBoardView
-(id)init{
    self=[super init];
    if (self) {
        CGFloat width=(VIEW_WIDTH-7*3)/8;
        CGFloat height=3*5+width*4;
        if(IS_IPHONE_X){
            height += SAFE_AREA_BOTTOM_HEIGHT;
        }
        self.frame=CGRectMake(0, 0, VIEW_WIDTH, height);
        self.backgroundColor=[UIColor blackColor];
        [self createChineseWordView];
        [self createNumWordView];
        
        UIView*view=[self viewWithTag:120];
        [self showOrHideView:YES theView:view];
    }
    return self;
}
-(void)createChineseWordView{
    UIView*view=[[UIView alloc] initWithFrame:self.bounds];
    view.tag=110;
    [self addSubview:view];
    CGFloat width=(self.frame.size.width-(COUNT_OF_ROW_CHINESE_WORD+1)*WORD_HOR_GAP)/COUNT_OF_ROW_CHINESE_WORD;
    for (int i=0; i<[CHINESE_WORD_ARRAY count]; i++) {
        int j=i/COUNT_OF_ROW_CHINESE_WORD;
        int k=i%COUNT_OF_ROW_CHINESE_WORD;
        CGRect frame=CGRectMake(k*width+(k+1)*WORD_HOR_GAP, j*width+(j+1)*WORD_HOR_GAP, width, width);
        NSString*word=[CHINESE_WORD_ARRAY objectAtIndex:i];
        UIButton*btn=[[UIButton alloc] init];
        [btn setFrame:frame];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn setTitle:word forState:UIControlStateNormal];
        btn.layer.cornerRadius=4;
        btn.layer.backgroundColor=[UIColor darkGrayColor].CGColor;
        btn.layer.masksToBounds=YES;
        [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
}
-(void)createNumWordView{
    UIView*view=[[UIView alloc] initWithFrame:self.bounds];
    view.tag=120;
    [self addSubview:view];
    CGFloat theight = IS_IPHONE_X?(self.frame.size.height-SAFE_AREA_BOTTOM_HEIGHT):self.frame.size.height;
    CGFloat btn_width=(self.frame.size.width-(COUNT_OF_ROW_NUM_WORD+1)*WORD_HOR_GAP)/COUNT_OF_ROW_NUM_WORD;
    CGFloat btn_height=(theight-5*WORD_HOR_GAP)/4;//总共4行
    for (int i=0; i<[NUMBERS_WORD_ARRAY count]; i++) {
        CGRect frame=CGRectMake(i*btn_width+(i+1)*WORD_HOR_GAP, WORD_HOR_GAP, btn_width, btn_height);
        NSString*word=[NUMBERS_WORD_ARRAY objectAtIndex:i];
        UIButton*btn=[[UIButton alloc] init];
        [btn setFrame:frame];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn setTitle:word forState:UIControlStateNormal];
        btn.layer.cornerRadius=4;
        btn.layer.backgroundColor=[UIColor darkGrayColor].CGColor;
        btn.layer.masksToBounds=YES;
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    CGFloat height=btn_height+WORD_HOR_GAP;
    for (int j=0; j<[LETTERS_ARRAY count]; j++) {
        NSString*word=[LETTERS_ARRAY objectAtIndex:j];
        int m=j/COUNT_OF_ROW_CHINESE_WORD;
        int n=j%COUNT_OF_ROW_CHINESE_WORD;
        CGRect frame=CGRectMake(n*btn_width+(n+1)*WORD_HOR_GAP, m*btn_height+(m+1)*WORD_HOR_GAP+height, btn_width, btn_height);
        UIButton*btn=[[UIButton alloc] init];
        [btn setFrame:frame];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateHighlighted];
        [btn setTitle:word forState:UIControlStateNormal];
        btn.layer.cornerRadius=4;
        btn.layer.backgroundColor=[UIColor darkGrayColor].CGColor;
        btn.layer.masksToBounds=YES;
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    UIButton*clearBtn=[[UIButton alloc] init];
    [clearBtn setFrame:CGRectMake(VIEW_WIDTH-btn_width*2-WORD_HOR_GAP*2, height+WORD_HOR_GAP, btn_width*2+WORD_HOR_GAP, btn_height)];
    clearBtn.layer.cornerRadius=4;
    clearBtn.layer.backgroundColor=[UIColor darkGrayColor].CGColor;
    clearBtn.layer.masksToBounds=YES;
    [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:clearBtn];
    
    UIImageView*clearImgView=[[UIImageView alloc] initWithFrame:CGRectMake(clearBtn.frame.size.width/2-12, clearBtn.frame.size.height/2-12, 24, 24)];
    [clearImgView setImage:[UIImage imageNamed:@"clear"]];
    [clearBtn addSubview:clearImgView];
    
    UIButton*doneBtn=[[UIButton alloc] init];
    [doneBtn setFrame:CGRectMake(clearBtn.frame.origin.x, clearBtn.frame.size.height+clearBtn.frame.origin.y+WORD_HOR_GAP, btn_width*2+WORD_HOR_GAP, btn_height*2+WORD_HOR_GAP)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    doneBtn.layer.cornerRadius=4;
    doneBtn.layer.backgroundColor=[UIColor darkGrayColor].CGColor;
    doneBtn.layer.masksToBounds=YES;
    [doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:doneBtn];
}
-(void)showOrHideView:(BOOL)hideFlag theView:(UIView*)view{
    [view setHidden:hideFlag];
}
-(void)showChineseKeyBoard{
    UIView*view1=[self viewWithTag:110];
    UIView*view2=[self viewWithTag:120];
    [self showOrHideView:NO theView:view1];
    [self showOrHideView:YES theView:view2];
}
-(void)showNumKeyBoard{
    UIView*view1=[self viewWithTag:110];
    UIView*view2=[self viewWithTag:120];
    [self showOrHideView:YES theView:view1];
    [self showOrHideView:NO theView:view2];
}
-(void)btnClick1:(UIButton*)sender{//汉字 按钮点击事件
    NSString*title=[sender titleForState:UIControlStateNormal];
    [self.delegate checkOneBtnClick:title];
    [self showNumKeyBoard];
}
-(void)btnClick2:(UIButton*)sender{//数字或字母 按钮点击事件
    NSString*title=[sender titleForState:UIControlStateNormal];
    [self.delegate checkOneBtnClick:title];
}
-(void)clearBtnClick:(UIButton*)sender{//清除按钮 点击事件
    [self.delegate clearBtnClick];
}
-(void)doneBtnClick:(UIButton*)sender{//完成按钮 点击事件
    [self.delegate doneBtnClick];
    [self showChineseKeyBoard];
}
//可以校验字符串是否是车牌号
+(BOOL)isValidateCarNoPrefix:(NSString*)carNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}
@end
