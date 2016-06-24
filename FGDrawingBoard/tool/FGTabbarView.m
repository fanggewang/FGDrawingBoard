//
//  FGTabbarView.m
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/11.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import "FGTabbarView.h"
#import "Alldefined.h"
#import "FGButtonModel.h"
#import "FGColorSelectionButton.h"


typedef void(^buttonAction)(void);


@interface FGTabbarView()

@property (nonatomic,strong) NSMutableArray *buttonArray;//用来储存添加的button按钮
@property (nonatomic,strong) NSMutableArray *actionArray;//


@property (nonatomic,strong) UIButton *ColourLastButton;

@property (nonatomic,strong) UIButton *lineWidthLastButton;

@end

@implementation FGTabbarView

- (NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
- (NSMutableArray *)actionArray{
    if (_actionArray == nil) {
        _actionArray = [NSMutableArray array];
        
    }
    return _actionArray;
}
- (void)addTAbbarButtomWithModels:(NSArray *)models{
    for (FGButtonModel *model in models) {
        if (![model isKindOfClass:[FGButtonModel class]]) {
            return;
        }
    }
    for (FGButtonModel *model in models) {
        if (model.isColorSelection) {
            FGColorSelectionButton *button = [FGColorSelectionButton sharedManager];
            button.model = model;
            [self addSubview:button];
            button.tag = self.buttonArray.count;
            [self.buttonArray addObject:button];
            [self.actionArray addObject:model.action];
            
            
        }else{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setImage:[UIImage imageNamed:model.image] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:model.slectImage] forState:UIControlStateSelected];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.selected = model.isSelected;
            [self addSubview:button];
            button.tag = self.buttonArray.count;
            [self.buttonArray addObject:button];
            [self.actionArray addObject:model.action];
        
        }
        
    }
    _ColourLastButton = self.buttonArray[0];
    
    _lineWidthLastButton = self.buttonArray[5];
    
    [self adjustmentButtonFram];
    
}


- (void)addTabbarButtonWithImage:(NSString *)image selectImage:(NSString *)selectImage andAction:(void(^)(void))action{
    
    //self.action = action;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    /*
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:10];
    [button.layer setBorderWidth:2];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
    
    [button.layer setBorderColor:color];
    */
    
    [self addSubview:button];
    button.tag = self.buttonArray.count;
    [self.buttonArray addObject:button];
    [self.actionArray addObject:action];
    
    
    
    [self adjustmentButtonFram];
    
    
    
    
}
- (void)buttonClick:(UIButton*)but{
    if (but.tag <= 4 ) {
        //颜色
        if (_ColourLastButton) {
            _ColourLastButton.selected = NO;
        }
        but.selected = YES;
        
        _ColourLastButton = but;
        
    }else if (but.tag <= 7){
        //笔画
        if (_lineWidthLastButton) {
            _lineWidthLastButton.selected = NO;
        }
        but.selected = YES;
        
        _lineWidthLastButton = but;
        
    }else{
        //其他
        
        
    }
    
    buttonAction action = self.actionArray[but.tag];
    //button调用的方法
    action();
    
    
    
}



- (void)adjustmentButtonFram{
    
    CGFloat buttonWidth = (kwidth - (self.buttonArray.count +1)*KTabbarGap)/self.buttonArray.count;
    CGFloat buttonHeight = buttonWidth*80/44;
    
    for (int i = 0; i<self.buttonArray.count; i++) {
        if (i == 3) {
            FGColorSelectionButton *button = self.buttonArray[3];
            CGFloat buttonX = KTabbarGap + i*(buttonWidth+ KTabbarGap);
            CGFloat buttony = 0;
            [button setFrame:CGRectMake(buttonX, buttony, buttonWidth, buttonHeight)];
            
            //防止循环引用
            __weak typeof(button) buttonView = button;
            [button addButtonWithBlock:^{
                
                if (_ColourLastButton) {
                    _ColourLastButton.selected = NO;
                }
                buttonView.button.selected = YES;
                _ColourLastButton = buttonView.button;
                
            }];
            
        }else{
            UIButton *button = self.buttonArray[i];
            CGFloat buttonX = KTabbarGap + i*(buttonWidth+ KTabbarGap);
            CGFloat buttony = 0;
            if (i>4) {
                buttony = 10;
            }
            [button setFrame:CGRectMake(buttonX, buttony, buttonWidth, buttonHeight)];
        }
        
    }
    
    self.frame = CGRectMake(0, kheight - buttonHeight, self.frame.size.width,buttonHeight);
    
}

@end
