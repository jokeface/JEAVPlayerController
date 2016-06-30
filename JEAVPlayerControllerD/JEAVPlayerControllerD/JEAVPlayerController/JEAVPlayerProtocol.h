//
//  JEAVPlayerProtocol.h
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol JEAVPlayerProtocol <NSObject> //代理设置为OverView,用来传递AVPlayerController的播放状态
-(void)JEAVPlayerStop;  //视频播放器已经停止
-(void)JEAVPlayerRun; //视频播放器正在播放
-(void)JEAVPlayerPause;//视频播放器已经暂停
-(void)JEAVPlayerLoading;//视频播放器正在加载


//当前播放时间和总共播放时间
-(void)JEAVPlayerWithCurrentTime:(CMTime)currentTime TotalTime:(CMTime)totalTime;
@end


@protocol JEAVPlayerControllerDelegate <NSObject> //代理设置为AVPlayerController的实例，用于响应OverView的控件点击时间
-(void)PauseJEAVPlayer;//暂停播放器
-(void)StartJEAVPlayer;//开始播放器
-(void)SeekTime:(CMTime)time;//设置播放的时间
