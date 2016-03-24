//
//  MacroDefineHeader.h
//  LadyLin
//
//  Created by xyc on 15/6/30.
//  Copyright (c) 2015年 LadyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef LadyLin_MacroDefineHeader_h
#define LadyLin_MacroDefineHeader_h

#endif

#define BaseUrlString  @"http://121.43.158.189/liu"



#define SIZEOFPAGE 10

#define redcolol YQ_Custom255Color(231.0,57.0,28.0) 
#define graycolor YQ_Custom255Color(190.0,190.0,190)
#define tablebarheight 49

#define Width(a)    a*SCREEN_WIDTH/320
#define Height(a)    a*SCREEN_HEIGHT/568
#define Color(a)    a/255.0

#define NavigationHeigt 64

#define YQ_Font(a)                              [UIFont fontWithName:@"MicrosoftYaHei" size:a]
#define YQ__font(b)                             YQ_Font(b)
#define UINib_Main_bundle(b)                    [UINib nibWithNibName:b bundle:MainBundle]

#define OringeColor                             [UIColor colorWithRed:1.0 green:120.0/255.0 blue:0.0 alpha:1.0]
#define YQ_Blue                                 YQ_Custom255Color(3,169,244)
#define YQ_Black                                YQ_Custom255Color(0,0,0)
#define YQ_lightGray                            YQ_Custom255Color(190,190,190)
#define YQ_RedColor                             YQ_Custom255Color(255, 68, 0)
#define YQ_Nav_RedColor                         YQ_Custom255Color(222, 65, 26)
#define YQ_Custom255Color(a,b,c)                [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1.00f]
#define COMMOM_Custom255Color(a,b,c)            YQ_Custom255Color(0xa,0xb,0xc)


#define SCREEN_HEIGHT                           [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                            [UIScreen mainScreen].bounds.size.width


#define YQ_xian                                 0.5f
#define YQ_XianColor                            YQ_Custom255Color(190,190,190)

#define YQClrcleHeadViewHeight 40.5

#define YQ_XianColor                            YQ_Custom255Color(190,190,190)
#define YQ_Jianxi                               10                                         //间隙高度
#define k_Left_Right_Space                      10
#define ScaleHeight(a)                          (a*ScaleForScreen)
#define ScaleForScreen                          (SCREEN_WIDTH/320)

#define YQQuickLog(a)                           [LogHelper logWithContent:a]

#define PageSize 20

#pragma mark - 
#pragma 字符宏定义

#define login_name @"login_name"
#define login_password @"login_password"
#define login_phone @"login_phone"

#define CodeStr @"000"



#define APPEND_STRING(x,y)                      [NSString stringWithFormat:@"%@%@",x,y]


