//
//  FGScratchImageView.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/31.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGScratchImageView : UIImageView
{
    CGPoint previousTouchLocation;
    CGPoint currentTouchLocation;
    
    CGImageRef hideImage;
    CGImageRef scratchImage;
    
    CGContextRef contextMask;
}

@end
 