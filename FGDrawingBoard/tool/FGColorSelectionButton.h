//
//  FGColorSelectionButton.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/6/23.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FGButtonModel;
typedef void(^buttonClick)(void);

@interface FGColorSelectionButton : UIView
@property (nonatomic,strong) FGButtonModel *model;
@property (nonatomic,strong) UIButton *button;

/*
 *添加button
 */
- (void)addButtonWithBlock:(buttonClick)block;

+ (FGColorSelectionButton *)sharedManager;
/**
 *改变背景颜色
 */
-(void)changegBackgranColor:(UIColor*)color;

@end
