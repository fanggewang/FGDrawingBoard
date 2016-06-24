//
//  Alldefined.h
//
//  Created by wangfangge on 15/8/6.
//  Copyright (c) 2015年 . All rights reserved.
//


//屏幕尺寸
#define screenRect  [[UIScreen mainScreen] bounds]


//字体大小
#define UIFont(x) [UIFont systemFontOfSize:x]
//加粗
#define UIBoldFont(x) [UIFont boldSystemFontOfSize:x]
//自定义View
#define KColourRow 2.0
#define KColourTrain 12.0
#define kColourGap 4.0
#define kColourWidth (kwidth - (KColourTrain +1)*kColourGap)/KColourTrain
#define KColoUrViewHeight (kColourWidth+kColourGap)*KColourRow+kColourGap

#define kDefaultAnimTime 0.3

#define kwidth [UIScreen mainScreen].bounds.size.width

#define KTabbarGap 4

#define kheight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define KName @"myName"

#define KPhone @"myPhone"

#define KBookClass @"bookClass"

#define KAudioClass @"audioClass"
