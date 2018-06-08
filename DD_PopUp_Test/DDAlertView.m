//
//  DDAlertView.m
//  DD_PopUp_Test
//
//  Created by 屈亮 on 2018/6/8.
//  Copyright © 2018年 屈亮. All rights reserved.
//
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
#import "DDAlertView.h"
@interface DDAlertView ()<UIScrollViewDelegate>
{
    UIPageControl *pageControll;
}
@property (nonatomic, strong)UIScrollView *scrollv;
@property (nonatomic, strong)NSArray *ddImageArr;
@end
@implementation DDAlertView
- (id)initWithCustomer:(UIView *)view imageArr:(NSArray *)imageArr theDelegate:(id)delegate
{
    if ([super init]) {
        self.frame = view.bounds;
        self.ddImageArr = imageArr;
        self.delegate = delegate;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        //可以在任何地方加上这句话,可以用来统一收起键盘
        [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
        //可以把当前页面加载到window上
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
        [self showAnimationforView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCurrentTapGestureOnGuangGao:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}
- (void)setDdImageArr:(NSArray *)ddImageArr
{
    _ddImageArr = ddImageArr;
    [self creatGuangGaoImageV];
    
}
- (void)showAnimationforView
{
    CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:@"opacity"];
    aniamtion.fromValue = [NSNumber numberWithFloat:0];
    aniamtion.toValue  = [NSNumber numberWithFloat:1];
    aniamtion.duration = 0.5;
    aniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:aniamtion forKey:@"opacity"];
}
//移除广告上的手势
- (void)removeCurrentTapGestureOnGuangGao:(UITapGestureRecognizer *)gesture
{
    UIView *subview = [self viewWithTag:99];
    UIView *shadowView = self;
    if (CGRectContainsPoint(subview.frame, [gesture locationInView:shadowView])) {
        
    }else{
        [self removeCurrentView];
    }
}
//移除当前页面
- (void)removeCurrentView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (void)creatGuangGaoImageV
{
    [self addSubview:self.scrollv];
    for (int i = 0; i < self.ddImageArr.count; i ++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollv.bounds.size.width *i, 0, _scrollv.bounds.size.width, _scrollv.bounds.size.height)];
        imageV.tag = 100 + i;
        imageV.image = [UIImage imageNamed:self.ddImageArr[i]];
        imageV.userInteractionEnabled = YES;
        [_scrollv addSubview:imageV];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [imageV addGestureRecognizer:gesture];
    }
    pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
    pageControll.center = CGPointMake(KWidth / 2, CGRectGetMaxY(_scrollv.frame) + 15);
    pageControll.numberOfPages = self.ddImageArr.count;
    pageControll.currentPage = 0;
    //[pageControll addTarget:self action:@selector(pageValueChage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControll];
    //关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 50, 50);
    closeBtn.center = CGPointMake(KWidth / 2, CGRectGetMaxY(pageControll.frame) + 30);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(removeCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
}

- (void)imageClick:(UITapGestureRecognizer *)gesture
{
    UIView *imageV = gesture.view;
    NSInteger imageTag = (long)imageV.tag - 100;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickAlertiViewIndex:)]) {
        [self.delegate clickAlertiViewIndex:imageTag];
        //移除广告页
        //[self removeCurrentView];
    }
}
//滑动控件
- (UIScrollView *)scrollv
{
    if (! _scrollv) {
        _scrollv =  [[UIScrollView alloc] initWithFrame:CGRectMake(40, 100, KWidth - 80, KHeight - 200)];
        _scrollv.contentSize = CGSizeMake((KWidth - 80) * self.ddImageArr.count, KHeight - 200);
        _scrollv.backgroundColor = [UIColor whiteColor];
        _scrollv.delegate = self;
        _scrollv.pagingEnabled = YES;
        _scrollv.bounces = NO;
        _scrollv.tag = 99;
        _scrollv.showsHorizontalScrollIndicator = NO;
        _scrollv.layer.cornerRadius = 10.0f;
        _scrollv.layer.masksToBounds = YES;
    }
    return _scrollv;
}
/*
- (void)pageValueChage:(UIPageControl *)page
{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollv.contentOffset = CGPointMake(self->_scrollv.bounds.size.width * page.currentPage, 0);
    }];
}
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.scrollv.bounds.size.width;
    pageControll.currentPage = index;
}
@end
