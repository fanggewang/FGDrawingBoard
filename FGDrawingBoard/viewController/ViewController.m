//
//  ViewController.m
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/10.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import "ViewController.h"
#import "FGTabbarView.h"
#import "FGButtonModel.h"
#import "Alldefined.h"
#import "FGPageNormalView.h"
#import "FGConfigManager.h"
#import "FGColourView.h"
#import "FGScratchView.h"
#import "FGAboutViewController.h"
#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong) NSMutableArray *buttonModels;

@property (nonatomic,strong) FGPageNormalView *pageView;//用于手绘的图层

@property (nonatomic,strong)FGScratchView *scratchView;//图片显示图层

@property (nonatomic,strong) UIImageView *imageView;//添加马赛克照片的图层

@property (nonatomic,strong) UIButton *mosaicButton;//马赛克按钮


@property (nonatomic,strong) FGColourView *colourView;

@end

@implementation ViewController

- (NSMutableArray *)buttonModels{
    if (_buttonModels == nil) {
        _buttonModels = [NSMutableArray array];
    }
    return _buttonModels;
}

- (FGColourView *)colourView{
    if (_colourView  ==nil) {
        _colourView = [FGColourView sharedManager];
        
        [_colourView eraseModeOnBlockChangOn:^{
            [_pageView eraseModeOn:NO];
        }];
        
        [self.view addSubview:_colourView];
        
    }
    return _colourView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self donlownDate];
    
    [self prepareUI];
    
    //[self inkModeOn];
    
    //[self disableScrolling];
    
}

//准备UI
- (void)prepareUI{
    
    /**
     *马赛克照片图层
     
     */
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight)];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
    
    /**
     *图片图层
     
     */
    
//    _scratchView = [[FGScratchView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight)];
//    //涂抹大小
//    [_scratchView setSizeBrush:50.0];
//    //_scratchView.userInteractionEnabled = NO;
//    [self.imageView addSubview:_scratchView];
    
    /**
     *手绘图层
     
     */
    _pageView = [[FGPageNormalView alloc]initWithPageSize:CGSizeMake(kwidth, kheight)];
    _pageView.backgroundColor = [UIColor clearColor];
    [_imageView addSubview:_pageView];
    /**
     删除按钮
     */
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setFrame:CGRectMake(kwidth-30, 5, 25, 25)];
    [deleteButton setImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
    [deleteButton setImage:[UIImage imageNamed:@"icon_clear_press"] forState:UIControlStateHighlighted];
    
    [deleteButton addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    /**
    开启关闭马赛克按钮
    */
    _mosaicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mosaicButton.hidden = YES;
    [_mosaicButton setFrame:CGRectMake(kwidth-30, 50, 25, 25)];
    [_mosaicButton setImage:[UIImage imageNamed:@"icon_macaic"] forState:UIControlStateNormal];
    [_mosaicButton setImage:[UIImage imageNamed:@"icon_macaic_xuan"] forState:UIControlStateSelected];
    [_mosaicButton addTarget:self action:@selector(openOrCloseMosaic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mosaicButton];
    
    FGTabbarView *tabbar = [[FGTabbarView alloc]initWithFrame:CGRectMake(0, kheight - 40, kwidth, 40)];
    
    tabbar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabbar];
    [tabbar addTAbbarButtomWithModels:self.buttonModels];
    /*
    for (FGButtonModel *model in self.buttonModels) {
        
        [tabbar addTabbarButtonWithImage:model.image selectImage:model.slectImage andAction:model.action];
        
    }*/
    
}

/**
 *开启关闭马赛克按钮
 */
- (void)openOrCloseMosaic:(UIButton *)mosaicButton{
    
    
    if (mosaicButton.selected) {
        //close
        mosaicButton.selected = NO;
        _pageView.hidden = NO;
        
    }else{
        //open
        mosaicButton.selected = YES;
        _pageView.hidden = YES;
        
    }
    
    
    
    
}


- (void)deleteAll{
    //删除所有的自由画笔
    [_pageView resetDrawing];
    
}

//准备数据
- (void)donlownDate{
    //黑色画笔
    [self establishButtonWithImage:@"black" slectImage:@"black_1" isSelected:YES isColorSelection:NO andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkColorWithIndex:0];
        [_pageView eraseModeOn:NO];
    }];
    
    //蓝色画笔
    [self establishButtonWithImage:@"blue" slectImage:@"blue_1" isSelected:NO isColorSelection:NO andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkColorWithIndex:1];
        [_pageView eraseModeOn:NO];
    }];
    
    //红色画笔
    [self establishButtonWithImage:@"red" slectImage:@"red_1" isSelected:NO isColorSelection:NO andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkColorWithIndex:2];
        [_pageView eraseModeOn:NO];
    }];
    
    //选色画笔
    [self establishButtonWithImage:@"color_3" slectImage:@"color_2" isSelected:NO isColorSelection:YES andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkColorWithIndex:3];
        [_pageView eraseModeOn:NO];
        [self.colourView goUp];
        
    }];
    
    
    //橡皮擦
    [self establishButtonWithImage:@"eraser" slectImage:@"eraser_1" isSelected:NO isColorSelection:NO andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkColorWithIndex:6];
        [_pageView eraseModeOn:YES];
        
    }];
    
    //小号笔
    [self establishButtonWithImage:@"icon_daxiao1" slectImage:@"icon_daxiao1_xuan" isSelected:YES isColorSelection:NO andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkLineWidth:3.0];
        
    }];
    
    //中号笔
    [self establishButtonWithImage:@"icon_daxiao2" slectImage:@"icon_daxiao2_xuan" isSelected:NO isColorSelection:NO andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkLineWidth:6.0];
    }];
    
    //大号笔
    [self establishButtonWithImage:@"icon_daxiao3" slectImage:@"icon_daxiao3_xuan" isSelected:NO isColorSelection:NO andAction:^{
        [[FGConfigManager sharedInstance] setFreeInkLineWidth:9.0];
    }];
    
    //打开相册
    [self establishButtonWithImage:@"icon_shedingditu" slectImage:@"icon_shedingditu_press" isSelected:NO isColorSelection:NO andAction:^{
        
        NSUInteger sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }];
    
    //存入相册
    [self establishButtonWithImage:@"icon_save" slectImage:@"icon_save_press" isSelected:NO isColorSelection:NO andAction:^{
        
        [self saveImageToPhotos:[self captureCurrentView:_imageView]];
        
    }];
    
    //更多选项
    [self establishButtonWithImage:@"icon_more" slectImage:@""  isSelected:NO isColorSelection:NO andAction:^{
        FGAboutViewController *vc = [[FGAboutViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        
    }];
    
    
    
}


//获取当前View的截图
-(UIImage *)captureCurrentView :(UIView *)view{
    
    
    CGRect frame = view.frame;
    
    UIGraphicsBeginImageContext(frame.size);
    
    CGContextRef contextRef =UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:contextRef];
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImage *saveImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage,CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height))];
    
    return saveImage;
    
}

//保存图片
-(void)saveImageToPhotos:(UIImage *)image{
    
    UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    
}


//保存回调

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg =@"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    NSLog(@"%@",msg);
    
    
}


#pragma mark 选择照片后的回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //self.imageView.image = [self Mosaic:image Level:50];
    //保持马赛克方格大小相同
    if (image.size.width == kwidth && image.size.height == kheight) {
        self.imageView.image = [ViewController transToMosaicImage:image blockLevel:kwidth/20];
    }else{
        self.imageView.image = image;
        self.imageView.image = [ViewController transToMosaicImage:[self captureCurrentView:self.imageView] blockLevel:kwidth/20];
    }
    
    //涂抹图
    if (_scratchView != nil) {
        [_scratchView removeFromSuperview];
        
    }
    UIImageView *sImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight)];
    sImg.contentMode = UIViewContentModeScaleAspectFill;
    sImg.image = image;
    _scratchView = [[FGScratchView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight)];
    //涂抹大小
    [_scratchView setSizeBrush:50.0];
//   _scratchView.userInteractionEnabled = NO;
    [_scratchView setHideView:sImg];
    [self.imageView addSubview:_scratchView];
    
    [self addImageEnd];
    
}

//添加图片后的操作
- (void)addImageEnd{
    //改变层级关系
    [self.imageView bringSubviewToFront:_pageView];
    //[self.pageView resetDrawing];
    self.mosaicButton.hidden = NO;
    
}


//
- (void)establishButtonWithImage:(NSString *)image slectImage:(NSString *)slectImage isSelected:(BOOL)selected isColorSelection:(BOOL)isColorSelection andAction:(void(^)(void))action{
    
    FGButtonModel *model = [[FGButtonModel alloc]init];
    model.image = image;
    model.slectImage = slectImage;
    model.action = action;
    model.isSelected = selected;
    model.isColorSelection = isColorSelection;
    [self.buttonModels addObject:model];

}

/*
 *转换成马赛克,level代表一个点转为多少level*level的正方形
 */
+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData (context);
    
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1)*width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }
    
    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              kBitsPerComponent,
                                              kBitsPerPixel,
                                              width*kPixelChannelCount ,
                                              colorSpace,
                                              kCGImageAlphaPremultipliedLast,
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       kBitsPerComponent,
                                                       width*kPixelChannelCount,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage;
    
}


@end
