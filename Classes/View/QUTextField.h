//
//  QUTextField.h
//  ChatSecure
//
//  Created by 瞿伦平 on 15/8/25.
//  Copyright (c) 2015年 Chris Ballinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QUTextField : UITextField
@property (strong, nonatomic) NSArray*  dataArr;
@property (assign, nonatomic) BOOL      pickerInput; //是否点击该组件显示选择框 默认为No  支持一级的点击显示
@property (assign, nonatomic) BOOL      pickerShowFirstRow; //是否显示选择数据里面的第一行文字   默认为YES

@property (nonatomic, copy) void (^callBack) (NSString *currentText);

- (instancetype)initWithData:(NSArray *)arr;
@end
