//
//  asdsd.m
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import "JEAVPlayerOverView.h"
#import "JEAVPlayerLoadingView.h"

typedef enum {
    JEPlayerStatusTypeBeforeBegin,//开始
    JEPlayerStatusTypeStop,//停止
    JEPlayerStatusTypePlause,//暂停
    JEPlayerStatusTypeLoading, //加载中
    JEPlayerStatusTypeRun //播放中
} JEPlayerStatusType;//枚举，用于记录播放器目前的状态，从而更新UI

@interface JEAVPlayerOverView ()
@property(nonatomic,weak)UIButton* PlayButton; //播放暂停按钮(大)
@property(nonatomic,weak)UIButton* LittlePlayButton; //播放暂停按钮(小)
@property(nonatomic,weak)UISlider* Slider; // 播放进度条

@property(nonatomic,weak)JEAVPlayerLoadingView* LoadingView;//加载圆圈控件

@property(nonatomic,weak)UILabel* CurrentTimeLable;//显示当前播放时间的控件

@property(nonatomic,weak)UILabel* TotalTimeLable;//显示剩余播放时间的控件

@property(assign,nonatomic)JEPlayerStatusType StatusType;// 当前播放的状态
@end

@implementation JEAVPlayerOverView

//初始化方法
-(instancetype)init
{
    if (self=[super init]) {
        
        
        //        [self setAlpha:0.5];
        
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews
{
    [self PlayButton];
    [self Slider];
    [self CurrentTimeLable];
    [self TotalTimeLable];
    [self LittlePlayButton];
    [self LoadingView];
}

#pragma mark 懒加载
-(JEAVPlayerLoadingView *)LoadingView
{
    if (!_LoadingView) {
        JEAVPlayerLoadingView* LoadingView=[[JEAVPlayerLoadingView alloc]init];
        
        LoadingView.contentMode = UIViewContentModeScaleAspectFit;
        LoadingView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _LoadingView=LoadingView;
        
        [self addSubview:LoadingView];
        
        
        NSLayoutConstraint* CenterXConstraint = [NSLayoutConstraint constraintWithItem:LoadingView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
        
        
        NSLayoutConstraint* CenterYConstraint = [NSLayoutConstraint constraintWithItem:LoadingView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        
        
        
        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:LoadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:80.0];
        
        NSLayoutConstraint* weightConstraint = [NSLayoutConstraint constraintWithItem:LoadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:80.0];
        
        [NSLayoutConstraint activateConstraints:@[CenterXConstraint,CenterYConstraint,heightConstraint,weightConstraint]];
    }
    return _LoadingView;
    
}
-(UIButton *)LittlePlayButton
{
    if (!_LittlePlayButton) {
        UIButton* LittlePlayButton=[[UIButton alloc]init];
        [LittlePlayButton addTarget:self action:@selector(LittlePlayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        LittlePlayButton.translatesAutoresizingMaskIntoConstraints = NO;
        [LittlePlayButton setImage:[UIImage imageNamed:@"videoplayer_icon_play"] forState:UIControlStateNormal];
        [LittlePlayButton setImage:[UIImage imageNamed:@"videoplayer_icon_play_highlighted"] forState:UIControlStateHighlighted];
        
        _LittlePlayButton=LittlePlayButton;
        [self addSubview:LittlePlayButton];
        
        NSLayoutConstraint* toRightConstraint =[NSLayoutConstraint constraintWithItem:LittlePlayButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.0f];
        
        NSLayoutConstraint* centerYConstraint =[NSLayoutConstraint constraintWithItem:LittlePlayButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:[self Slider] attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        
        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:LittlePlayButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:20.0];
        
        NSLayoutConstraint* weightConstraint = [NSLayoutConstraint constraintWithItem:LittlePlayButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:20.0];
        [NSLayoutConstraint activateConstraints:@[toRightConstraint,centerYConstraint,heightConstraint,weightConstraint]];
        
    }
    return _LittlePlayButton;
}
-(UILabel *)TotalTimeLable
{
    if (!_TotalTimeLable) {
        UILabel* TotalTimeLable=[[UILabel alloc]init];
        [TotalTimeLable setFont:[UIFont systemFontOfSize:10]];
        TotalTimeLable.translatesAutoresizingMaskIntoConstraints = NO;
        [TotalTimeLable setTextColor:[UIColor whiteColor]];
        [TotalTimeLable setText:@"00:00"];
        _TotalTimeLable=TotalTimeLable;
        [self addSubview:TotalTimeLable];
        
        NSLayoutConstraint* ToLeftConstraint = [NSLayoutConstraint constraintWithItem:TotalTimeLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[self Slider] attribute:NSLayoutAttributeRight multiplier:1.0f constant:10.0f];
        NSLayoutConstraint* ToBaseLineConstraint = [NSLayoutConstraint constraintWithItem:TotalTimeLable attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:[self Slider] attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        NSLayoutConstraint* ToRightConstraint = [NSLayoutConstraint constraintWithItem:TotalTimeLable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10.0f];
        [NSLayoutConstraint activateConstraints:@[ToRightConstraint,ToLeftConstraint,ToBaseLineConstraint]];
        
    }
    return _TotalTimeLable;
}
-(UILabel *)CurrentTimeLable
{
    if (!_CurrentTimeLable) {
        UILabel* CurrentTimeLable=[[UILabel alloc]init];
        [CurrentTimeLable setFont:[UIFont systemFontOfSize:10]];
        CurrentTimeLable.translatesAutoresizingMaskIntoConstraints = NO;
        [CurrentTimeLable setTextColor:[UIColor whiteColor]];
        [CurrentTimeLable setText:@"00:00"];
        _CurrentTimeLable=CurrentTimeLable;
        [self addSubview:CurrentTimeLable];
        
        NSLayoutConstraint* ToLefrConstraint = [NSLayoutConstraint constraintWithItem:CurrentTimeLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[self LittlePlayButton] attribute:NSLayoutAttributeRight multiplier:1.0f constant:10.0f];
        NSLayoutConstraint* ToBaseLineConstraint = [NSLayoutConstraint constraintWithItem:CurrentTimeLable attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:[self Slider] attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        
        [NSLayoutConstraint activateConstraints:@[ToLefrConstraint,ToBaseLineConstraint]];
        
    }
    return _CurrentTimeLable;
}
-(UISlider *)Slider
{
    if (!_Slider) {
        UISlider* Slider=[[UISlider alloc]init];
        [Slider addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventValueChanged];
        [Slider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [Slider addTarget:self action:@selector(sliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [Slider setMinimumTrackTintColor:[UIColor whiteColor]];
        [Slider setMaximumTrackTintColor:[UIColor grayColor]];
        [Slider  setThumbImage:[UIImage imageNamed:@"videoplayer_erect_icon_round"] forState:UIControlStateNormal];
        Slider.translatesAutoresizingMaskIntoConstraints = NO;
        _Slider=Slider;
        [self addSubview:Slider];
        
        
        NSLayoutConstraint* ToLeftConstraint = [NSLayoutConstraint constraintWithItem:Slider attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[self CurrentTimeLable] attribute:NSLayoutAttributeRight multiplier:1.0f constant:10.0f];
        
        
        NSLayoutConstraint* ToButtonConstraint = [NSLayoutConstraint constraintWithItem:Slider attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-20.0];
        
        [NSLayoutConstraint activateConstraints:@[ToLeftConstraint,ToButtonConstraint]];
        
        //        NSLayoutConstraint* weightConstraint = [NSLayoutConstraint constraintWithItem:Slider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:80.0];
        
    }
    return _Slider;
}
-(UIButton *)PlayButton
{
    if (!_PlayButton) {
        UIButton* PlayButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [PlayButton setImage:[UIImage imageNamed:@"videoplayer_icon_play"] forState:UIControlStateNormal];
        [PlayButton setImage:[UIImage imageNamed:@"videoplayer_icon_play_highlighted"] forState:UIControlStateHighlighted];
        PlayButton.contentMode = UIViewContentModeScaleAspectFit;
        PlayButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [PlayButton addTarget:self action:@selector(PlayButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _PlayButton=PlayButton;
        
        [self addSubview:PlayButton];
        
        
        NSLayoutConstraint* CenterXConstraint = [NSLayoutConstraint constraintWithItem:PlayButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
        
        
        NSLayoutConstraint* CenterYConstraint = [NSLayoutConstraint constraintWithItem:PlayButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        
        
        
        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:PlayButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:80.0];
        
        NSLayoutConstraint* weightConstraint = [NSLayoutConstraint constraintWithItem:PlayButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:80.0];
        
        [NSLayoutConstraint activateConstraints:@[CenterXConstraint,CenterYConstraint,heightConstraint,weightConstraint]];
    }
    return _PlayButton;
}

@end
