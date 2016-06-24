//
//  FGColourView.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/24.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^changeeraseModeOn) ();
@interface FGColourView : UIView

/**
 **上升
 
 */
- (void)goUp;


/**
 **下降
 
 */
- (void)goDown;



/*
 **设置点击Block
 */

- (void)eraseModeOnBlockChangOn:(changeeraseModeOn)changOn;

+ (FGColourView *)sharedManager;
@end
