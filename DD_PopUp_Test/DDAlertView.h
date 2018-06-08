//
//  DDAlertView.h
//  DD_PopUp_Test
//
//  Created by 屈亮 on 2018/6/8.
//  Copyright © 2018年 屈亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDAlertViewDelgate<NSObject>

- (void)clickAlertiViewIndex:(NSInteger)index;

@end
@interface DDAlertView : UIView
@property (nonatomic, weak)id<DDAlertViewDelgate>delegate;
- (id)initWithCustomer:(UIView *)view imageArr:(NSArray *)imageArr theDelegate:(id)delegate;
@end
