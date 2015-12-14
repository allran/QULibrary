//
//  QUTextField.h
//  ChatSecure
//
//  Created by 瞿伦平 on 15/8/25.
//  Copyright (c) 2015年 Chris Ballinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QUTextField : UITextField
@property (assign, nonatomic) BOOL                  pickerInput; //是否点击该组件显示选择框 默认为No  支持一级的点击显示
@property (assign, nonatomic) BOOL                  pickerShowFirstRow; //是否显示选择数据里面的第一行文字   默认为YES

@property (strong, nonatomic) NSArray*              dataArr;

@property (strong, nonatomic) UIDatePicker*         datePickerView; //时间选择控件，放到公共属性是因为方便自定义。
@property (strong, nonatomic) NSDateFormatter*      dateFormatter;  //显示在文本的时间格式
@property (strong, nonatomic) NSDate*               date;

@property (nonatomic, copy) void (^callBack) (NSString *currentText);  //返回当前选择文字
@property (nonatomic, copy) void (^callBackDate) (NSDate *currentDate, NSString *currentText); //返回当前选择时间

- (instancetype)initWithPlaceholder:(NSString *)placeholder data:(NSArray *)arr;
- (instancetype)initWithPlaceholder:(NSString *)placeholder date:(NSDate *)date;
-(void)updateValue;
@end


//demo
//QUTextField *field1 = [[QUTextField alloc] initWithPlaceholder:@"到达时间" data:[NSArray arrayWithObjects:@"AA", @"BB", @"CC", @"DD", nil]];
//field1.borderStyle = UITextBorderStyleRoundedRect;
//field1.callBack = ^(NSString *currentText){
//    NSLog(@"当前文字更改为:%@", currentText);
//};
//[superView addSubview:field1];
//
//QUTextField *field2 = [[QUTextField alloc] initWithPlaceholder:@"请选择时间" date:[NSDate date]];
//field2.borderStyle = UITextBorderStyleRoundedRect;
//field2.callBackDate = ^(NSDate *currentDate, NSString *currentText){
//    NSLog(@"当前时间更改为:%@", currentText);
//};
//[superView addSubview:field2];
