#ifdef DEBUG
#define MLLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define MLLog(format, ...)
#endif

#define MLLog_VC(_Method_)  MLLog(@"%@ %@",[self description],@_Method_);



#define COLOR(r,g,b)                [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR_RGBA(r,g,b,a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define IMG(_File_)                 [UIImage imageNamed:_File_]



//helper macro that creates CGRect, CGSize, CGPoint
#define cgr(__X__, __Y__, __W__, __H__) CGRectMake(__X__, __Y__, __W__, __H__)  
#define cgs(__X__, __Y__)			CGSizeMake(__X__, __Y__)
#define cgp(__X__, __Y__)			CGPointMake(__X__,__Y__)


//print a rect infomation
#define log_rect(__RECT__) \
MLLog(@"%s : {x=%.2f, y=%.2f, w=%.2f, h=%.2f}", #__RECT__, __RECT__.origin.x, __RECT__.origin.y, \
__RECT__.size.width, __RECT__.size.height)


//init a viewController with nib file
#define initViewController(__CLASSNAME__) [[__CLASSNAME__ alloc] initWithNibName:@#__CLASSNAME__ bundle:nil]


#ifdef __IPHONE_6_0
# define QU_TextAlignmentLeft   NSTextAlignmentLeft
# define QU_TextAlignmentCenter NSTextAlignmentCenter
# define QU_TextAlignmentRight  NSTextAlignmentRight
#else
# define QU_TextAlignmentLeft   UITextAlignmentLeft
# define QU_TextAlignmentCenter UITextAlignmentCenter
# define QU_TextAlignmentRight  UITextAlignmentRight
#endif



#define showMessage(__MESSAGE__) \
UIAlertView *alertView_ = [[UIAlertView alloc] initWithTitle:@"提示" \
message:__MESSAGE__ \
delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil]; \
[alertView_ show]; 


#define NumberWithFloat(i)       [NSNumber numberWithFloat:i]
#define NumberWithInt(i)       [NSNumber numberWithInt:i]
#define NumberWithBool(i)       [NSNumber numberWithBool:i]

#define  DefaultPadding 10




#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//Demo:  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5")) [super viewWillLayoutSubviews];


#define DeviceIsRetina()				([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640.0, 960.0), [[UIScreen mainScreen] currentMode].size) : NO)
#define DeviceIsiPod()                  ([[[UIDevice currentDevice] systemName] isEqualToString:@"iPod touch"])
#define DeviceIsiPod5()                 ([[[UIDevice currentDevice] systemName] isEqualToString:@"iPod touch"] && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define DeviceIsiPhone()				([[UIScreen mainScreen] bounds].size.height == 480.0)
#define DeviceIsiPhone5()				([[UIScreen mainScreen] bounds].size.height == 568.0)
#define DeviceIsiPad()                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SystemIsiOS4()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 5.0)
#define SystemIsiOS5()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 6.0)
#define SystemIsiOS6()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0)
#define SystemIsiOS7()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)//判断是否为IOS7
#define SystemIsiOS8()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)//判断是否为IOS8
#define DEVICE_StatuBar_Height          (20.0)





#define DEVICE_NavBar_Height            (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?64.0:44.0f)
#define DEVICE_TabBar_Height            (50.0)
#define DEVICE_Width                    ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_Height                   ([[UIScreen mainScreen] bounds].size.height)
#define DEVICE_InStatusBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_StatuBar_Height)
#define DEVICE_InNavTabBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_NavBar_Height - DEVICE_TabBar_Height)
#define DEVICE_InNavBar_Height          (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?[[UIScreen mainScreen] bounds].size.height-64.0:[[UIScreen mainScreen] bounds].size.height-64.0f)
#define DEVICE_StatuNavBar_Height       (DEVICE_StatuBar_Height + DEVICE_NavBar_Height)
#define DEVICE_ContentView_Height (DEVICE_Height - DEVICE_InStatusBar_Height)
#define TOP_Height                      (DEVICE_StatuBar_Height+DEVICE_NavBar_Height)

#define PerDeviceWidth(__NUMBER__)      (DEVICE_Width * __NUMBER__)
#define PerDeviceHeight(__NUMBER__)     (DEVICE_Height * __NUMBER__)



#define INDEXPATH_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
indexPath;\
})\

#define CELL_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
UITableViewCell *cell=[tableview cellForRowAtIndexPath:indexPath];\
cell;\
})\





static inline NSString *StringWithInteger(NSInteger _Value_)
{
    return [NSString stringWithFormat:@"%li",(long)_Value_];
}
static inline NSString *StringWithInt(int _Value_)
{
	return [NSString stringWithFormat:@"%i",_Value_];
}
static inline NSString *StringWithBool(BOOL _Value_)
{
    return [NSString stringWithFormat:@"%i",_Value_];
}
static inline NSString *StringWithDouble(double _Value_)
{
    return [NSString stringWithFormat:@"%.2f",_Value_];
}



typedef enum {
    kTableNote_Nothing,//空
	kTableNote_NoData,//无数据
    kTableNote_ConError,//链接错误
	kTableNote_ConErrorTimedOut,//链接超时错误
    kTableNote_UpdateError,//下载错误
	kTableNote_UpdateOK,//下载成功
	kTableNote_NoRecord,//暂无记录
} kTableNoteType;






typedef struct {
    int year;
	int month;
    int day;
} sBirthday;//生日

static inline sBirthday QUBirthdayMake(int year, int month, int day)
{
	return (sBirthday) {year, month, day};
}
