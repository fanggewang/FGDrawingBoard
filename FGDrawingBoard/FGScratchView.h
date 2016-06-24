//
//  FGScratchView.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/30.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGScratchView : UIView
{
    CGPoint previousTouchLocation;
    CGPoint currentTouchLocation;
    
    CGImageRef hideImage;
    CGImageRef scratchImage;
    
    CGContextRef contextMask;
}
@property (nonatomic, assign) float sizeBrush;
@property (nonatomic, strong) UIView *hideView;

- (void)setHideView:(UIView *)hideView;
- (UIImage *)getEndImg;

@end
