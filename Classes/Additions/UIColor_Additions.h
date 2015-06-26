//
//  UIColor_Additions.h
//  FootBallScore
//
//  Created by Qu Allren on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (Additions)
+(UIColor *) colorWithHexString: (NSString *) stringToConvert;
@end
