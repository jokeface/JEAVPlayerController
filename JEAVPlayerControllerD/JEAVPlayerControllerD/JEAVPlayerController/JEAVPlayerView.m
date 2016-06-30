//
//  JEAVPlayerView.m
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import "JEAVPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "JEAVPlayerOverView.h"

@implementation JEAVPlayerView

+(Class)layerClass
{
    /*
     * 设置根图层为AVPlayerLayer
     * AVPlayerLayer构建于CoreAnimation之上，用作于视频内容的渲染
     */
    return [AVPlayerLayer class];
}

-(instancetype)initWithPlayer:(AVPlayer *)player
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = [UIColor blackColor];
        
        //自动调整宽高
        self.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        //给AVPlayerLayer添加 AVPlayer
        [(AVPlayerLayer*)[self layer] setPlayer:player];
        
        //遮罩图层，用户放置各种控件
        JEAVPlayerOverView* OverView=[[JEAVPlayerOverView alloc]init];
        _OverView=OverView;
        [self addSubview:OverView];
    }
    return self;
}

@end
