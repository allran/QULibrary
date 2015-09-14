//
//  WebVC.h
//  GoApp
//
//  Created by 瞿伦平 on 15/2/11.
//  Copyright (c) 2015年 allran.mine. All rights reserved.
//

#import "QUVC.h"

@interface QUWebVC : QUVC<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate,UIWebViewDelegate>
@property(nonatomic,strong) NSString *linkUrl;
@property (nonatomic,strong) UIWebView *shareWebView;
@end
