//
//  ViewController.m
//  DD_PopUp_Test
//
//  Created by 屈亮 on 2018/6/8.
//  Copyright © 2018年 屈亮. All rights reserved.
//
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "DDAlertView.h"
@interface ViewController ()<DDAlertViewDelgate>

/**
 广告弹出按钮
 */
@property (nonatomic, strong)UIButton *showBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = @"仿滴滴广告弹出框";
    [self.view addSubview:self.showBtn];

   
}


- (UIButton *)showBtn
{
    if (!_showBtn) {
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn.frame = CGRectMake(0, 0, 100, 40);
        _showBtn.center = self.view.center;
        _showBtn.layer.borderWidth = 1.0;
        _showBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_showBtn setTitle:@"弹出" forState:UIControlStateNormal];
        [_showBtn addTarget:self action:@selector(showClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}

- (void)showClick
{
    NSArray *iamgeArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    //点击
    DDAlertView *ddView = [[DDAlertView alloc] init];
    [ddView initWithCustomer:self.view imageArr:iamgeArr theDelegate:self];
}
- (void)clickAlertiViewIndex:(NSInteger)index
{
    NSLog(@"点击图片的tag===%ld",index);
}
@end
