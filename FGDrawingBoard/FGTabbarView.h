//
//  FGTabbarView.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/11.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGTabbarView : UIView

/*
 *单个button的添加
 */
- (void)addTabbarButtonWithImage:(NSString *)image selectImage:(NSString *)selectImage andAction:(void(^)(void))action;
/**
 *根据FGButtonModel的数组来创建button
 
 */
- (void)addTAbbarButtomWithModels:(NSArray *)models;

@end
