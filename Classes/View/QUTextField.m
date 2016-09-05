//
//  QUTextField.m
//  ChatSecure
//
//  Created by 瞿伦平 on 15/8/25.
//  Copyright (c) 2015年 Chris Ballinger. All rights reserved.
//

#import "QUTextField.h"
#import <IQKeyboardManager/IQUIView+IQKeyboardToolbar.h>

@interface QUTextField ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSDate*               selectDate;
@property (nonatomic, strong) NSString*             selectText;
@end

@implementation QUTextField

- (void)initialize
{
    self.pickerInput = NO;
    self.pickerShowFirstRow = YES;
    if (self.dataArr == nil)
        self.dataArr = [NSArray array];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder data:(NSArray *)arr
{
    self = [super init];
    if (self) {
        [self initialize];
        self.pickerInput = YES;
        self.placeholder = placeholder;
        self.dataArr = [NSArray arrayWithArray:arr];
    }
    return self;
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder date:(NSDate *)date
{
    self = [super init];
    if (self) {
        [self initialize];
        self.pickerInput = YES;
        self.placeholder = placeholder;
        self.date = date;
    }
    return self;
}



-(void)setPickerInput:(BOOL)pickerInput
{
    _pickerInput = pickerInput;
    [self loadSubPickerView];
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = [dataArr copy];
    _pickerInput = dataArr.count > 0 ? YES : NO;
        
    [self loadSubPickerView];
}

-(void)setDate:(NSDate *)date
{
    _date = [date copy];
    _pickerInput = date!=nil ? YES : NO;
    [self loadSubPickerView];
    
    self.datePickerView.date = date;
}

-(void)loadSubPickerView
{
    if ((_dataArr.count > 0 || _date != nil) && _pickerInput == YES) {
        self.delegate = self;
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        [self addCancelDoneOnKeyboardWithTarget:self cancelAction:@selector(leftMethod:) doneAction:@selector(rightMethod:)];
        
        if (_dataArr.count > 0) {
            if (_pickerView == nil) {
                UIPickerView *picker = [[UIPickerView alloc] init];
                [picker setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
                [picker setShowsSelectionIndicator:YES];
                [picker setDelegate:self];
                [picker setDataSource:self];
                self.pickerView = picker;
                self.inputView = picker;
            }
            if (_pickerShowFirstRow == YES && self.text.length==0)
                [self loadDataWithSelectRow:0 inComponent:0 animated:NO];
            
            return;
        }  else if (_date != nil) {
            if (_datePickerView == nil) {
                UIDatePicker *picker = [[UIDatePicker alloc] init];
                picker.datePickerMode = UIDatePickerModeDateAndTime;
                picker.date = _date;
                [picker setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
                [picker addTarget:self action:@selector(dateFieldChooseDate:) forControlEvents:UIControlEventValueChanged];
                self.datePickerView = picker;
                self.inputView = picker;
            }
            if (_pickerShowFirstRow == YES)
                [self dateFieldChooseDate:nil];
        }
    } else {
        self.pickerView = nil;
        self.datePickerView = nil;
        self.selectText = nil;
        self.selectDate = nil;
        self.inputView = nil;
        self.text = nil;
    }
}

-(void)leftMethod:(id)sender
{
    if (self.callBack && self.pickerView!=nil)
        self.callBack(nil);
    else if (self.callBackDate && self.datePickerView!=nil)
        self.callBackDate(nil, nil);
    [self resignFirstResponder];
}

-(void)rightMethod:(id)sender
{
    if (self.callBack && self.pickerView!=nil) {
        self.text = _selectText;
        self.callBack(_selectText);
    }
    else if (self.callBackDate && self.datePickerView!=nil) {
        self.text = _selectText;
        self.date = _selectDate;
        self.callBackDate(_selectDate, _selectText);
    }
    [self resignFirstResponder];
}


#pragma mark - UITextField overrides

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    if (_dataArr.count > 0 || _pickerInput==YES)
        return CGRectZero;

    return [super caretRectForPosition:position];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;
}

#pragma mark UIPickerView delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_dataArr.count >= row+1)
        return [_dataArr objectAtIndex:row];
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self loadDataWithSelectRow:row inComponent:component animated:YES];
}



-(void)loadDataWithSelectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animate
{
    if (_dataArr.count >= row+1) {
        NSString *name = [_dataArr objectAtIndex:row];
        self.selectText = name;
        
//        if (self.callBack)
//            self.callBack(name);
    }
}

#pragma mark UIDatePicker delegate
- (void)dateFieldChooseDate:(UIDatePicker *)sender
{
    NSDate *date = sender.date;
    if (date == nil)
        date = _datePickerView.date;
    if (date == nil)
        date = _date;
    
//    if (self.dateFormatter == nil) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        self.dateFormatter = formatter;
//    }
    NSString *formatStr = @"";
    if (_datePickerView.datePickerMode == UIDatePickerModeDate)
        formatStr = @"yyyy-MM-dd";
    else if (_datePickerView.datePickerMode == UIDatePickerModeDateAndTime)
        formatStr = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    if (self.datePickerView.timeZone != nil)
        formatter.timeZone = self.datePickerView.timeZone;
    
    NSString *dateString = [formatter stringFromDate:date];
    self.selectText = dateString;
    self.selectDate = date;
    
    self.text = dateString;
    
//    if (self.callBackDate)
//        self.callBackDate(date, dateString);
}

-(void)updateValue
{
    if (_date != nil) {
        [self dateFieldChooseDate:nil];
    }
}

@end
