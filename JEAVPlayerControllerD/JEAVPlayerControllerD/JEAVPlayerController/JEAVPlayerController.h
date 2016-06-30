//
//  JEAVPlayerController.h
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEAVPlayerController : UIView
//初始化方法，传入视频资源URL
-(id)initWithURL:(NSURL*)assetURL;

@property(strong,nonatomic,readonly)UIView* view;

@end
