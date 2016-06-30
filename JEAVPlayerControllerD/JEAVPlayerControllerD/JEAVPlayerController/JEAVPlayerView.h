//
//  JEAVPlayerView.h
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayer,JEAVPlayerOverView;
@interface JEAVPlayerView : UIView 
@property(weak,nonatomic)JEAVPlayerOverView* OverView;//遮罩图层，用于放置各种控件
//初始化方法
-(instancetype)initWithPlayer:(AVPlayer*)player;
@end
