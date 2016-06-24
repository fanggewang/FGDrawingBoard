//
//  FGConfigManager.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/12.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FGConfigManager : NSObject
// 取单例
+(id)sharedInstance;

// 获取颜色数组
-(NSArray *)getStandardColorArray;

-(void)setFreeInkColorWithIndex:(NSInteger)index;
-(UIColor *)getFreeInkColor;
-(UIColor *)getFreeInkColorWithIndex:(NSInteger)index;
-(NSArray *)getInkColorValues;
-(NSString *)getInkColorString;
-(NSInteger)getInkColorIndex;

// 设定自由画笔笔迹宽度
-(void)setFreeInkLineWidth:(CGFloat)lineWidth;

-(CGFloat)getFreeInkLineWidth;



@end
