//
//  JEAVPlayerController.m
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import "JEAVPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "JEAVPlayerView.h"
//#import "JEAVPlayerProtocol.h"
//#import "JEAVPlayerOverView.h"


@interface JEAVPlayerController()
/*
 * AVAsset 基本属性：描述多媒体基本信息
 */
@property(strong,nonatomic)AVAsset* asset;

/*
 * AVPlayerItem 建立媒体资源动态模型，主要用于媒体的状态监听，比如是否可以播放，是否加载失败，等等功能
 */
@property(strong,nonatomic)AVPlayerItem* playerItem;

/*
 * AVPlayer AVFoundation的主要对象，是一个不可见的组件，类似于控制器
 * 可以播放音频和视频，所以AVPlayer,即可以做视频播放器，也可以做音频播放器
 */
@property(strong,nonatomic)AVPlayer* player;

@property(strong,nonatomic)JEAVPlayerView* playerView; //视频播放图层，用于渲染图层

//@property(nonatomic,weak)id<JEAVPlayerProtocol> delegate;
@end

@implementation JEAVPlayerController

-(id)initWithURL:(NSURL *)assetURL
{
    if (self = [super init]) {
        
        //将URL传递给初始化方法来创建一个AVAsset
        _asset=[AVAsset assetWithURL:assetURL];
        
        [self PrepareToPlay];
        
        
    }
    return self;
}
-(void)PrepareToPlay
{
    
    NSArray* keys = @[@"tracks",@"duration",@"commonMetadata"];
    
    //创建一个AVPlayerItem automaticallyLoadedAssetKeys：keys ，这个方法是说明，在视频播放之前，你想从 asset中获得的信息
    _playerItem=[AVPlayerItem playerItemWithAsset:_asset automaticallyLoadedAssetKeys:keys];
    
    //监听_playerItem中status属性的变化
    [_playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
    
    //监听_playerItem中是否为空
    [_playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    //监听_playerItem中是否已经满了
    
    [_playerItem addObserver:self forKeyPath:@"playbackBufferFull" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    [_playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    
    _player=[AVPlayer playerWithPlayerItem:_playerItem];
    
    
    _playerView=[[JEAVPlayerView alloc]initWithPlayer:_player];
    
    
    
//    [self setDelegate:_playerView.OverView];
//    _playerView.OverView.delegate=self;
}
-(UIView *)view
{
    return _playerView;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        [NSThread currentThread];
    }
}



-(void)dealloc
{
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [_playerItem removeObserver:self forKeyPath:@"playbackBufferFull"];
    [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}


@end
