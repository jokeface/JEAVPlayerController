//
//  JEAVPlayerLoadingView.m
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import "JEAVPlayerLoadingView.h"

@interface JEAVPlayerLoadingView ()
@property(weak,nonatomic)UIImageView* imageView; //转圈圈图片

@property(weak,nonatomic)UIImageView* backImageView; //转圈圈图片的背景
@end

@implementation JEAVPlayerLoadingView


#pragma mark 懒加载
-(UIImageView *)backImageView
{
    if (!_backImageView) {
        UIImageView* backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"videoplayer_loadingbar"]];
        _backImageView=backImageView;
        [self addSubview:backImageView];
        backImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat margin = 0.0f;
        NSLayoutConstraint * topCons = [NSLayoutConstraint constraintWithItem:backImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
        NSLayoutConstraint * leftCons = [NSLayoutConstraint constraintWithItem:backImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
        
        NSLayoutConstraint * BottomCons = [NSLayoutConstraint constraintWithItem:backImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin];
        NSLayoutConstraint * RightCons = [NSLayoutConstraint constraintWithItem:backImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
        
        [NSLayoutConstraint activateConstraints:@[topCons,BottomCons,RightCons,leftCons]];
    }
    return _backImageView;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"videoplayer_loading"]];
        _imageView=imageView;
        [self addSubview:imageView];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat margin = 10.0f;
        NSLayoutConstraint * topCons = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
        NSLayoutConstraint * leftCons = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
        
        NSLayoutConstraint * BottomCons = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin];
        NSLayoutConstraint * RightCons = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
        
        [NSLayoutConstraint activateConstraints:@[topCons,BottomCons,RightCons,leftCons]];
    }
    return _imageView;
}

//旋转动画的执行
-(void)StartAnimation
{
    CABasicAnimation* rotationAnimation =
    
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    
    rotationAnimation.duration = 2.0f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.repeatCount=MAXFLOAT;
    [_imageView.layer addAnimation:rotationAnimation forKey:@"loading"];
}

-(void)Show
{
    [self setHidden:NO];
    [self StartAnimation];
}
-(void)Hide
{
    [self setHidden:YES];
    [_imageView.layer removeAnimationForKey:@"loading"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
