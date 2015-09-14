//
//  QUTextField.m
//  ChatSecure
//
//  Created by 瞿伦平 on 15/8/25.
//  Copyright (c) 2015年 Chris Ballinger. All rights reserved.
//

#import "QUTextField.h"


@interface QUTextField ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    
}

@property (nonatomic, strong) UIPickerView *pickerView;
@end

@implementation QUTextField

- (void)initialize
{
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    self.delegate = self;
    
    self.pickerInput = NO;
    self.pickerShowFirstRow = YES;
    if (self.dataArr == nil)
        self.dataArr = [NSArray array];
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

- (instancetype)initWithData:(NSArray *)arr
{
    self = [super init];
    if (self) {
        [self initialize];
        self.dataArr = [NSArray arrayWithArray:arr];
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
    [self loadSubPickerView];
}

-(void)loadSubPickerView
{
    if (_dataArr.count > 0 || _pickerInput==YES) {
        if (self.pickerView == nil) {
            self.pickerView = [[UIPickerView alloc] init];
            [self.pickerView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
            [self.pickerView setShowsSelectionIndicator:YES];
            [self.pickerView setDelegate:self];
            [self.pickerView setDataSource:self];
            self.inputView = self.pickerView;
        }
        if (_pickerShowFirstRow)
            [self loadDataWithSelectRow:0 inComponent:0 animated:NO];
    } else {
        self.pickerView = nil;
        self.inputView = nil;
    }
}


#pragma mark - UITextField overrides

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    if (_dataArr.count > 0 || _pickerInput==YES) {
        return CGRectZero;
    }
    return [super caretRectForPosition:position];
    
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
        self.text = name;
        
        if (self.callBack)
            self.callBack(name);
    }
}


@end
