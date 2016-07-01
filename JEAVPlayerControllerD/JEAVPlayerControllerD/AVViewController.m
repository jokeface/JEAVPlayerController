//
//  AVViewController.m
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/7/1.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import "AVViewController.h"
#import "JEAVPlayerController.h"

@interface AVViewController ()
@property(nonatomic,strong)JEAVPlayerController* playerController;
@end

@implementation AVViewController
-(void)viewDidLoad
{
    NSURL* assetURL= [NSURL URLWithString:@"http://mvvideo1.meitudata.com/56e93404432e71916.mp4"];
    _playerController =[[JEAVPlayerController alloc]initWithURL:assetURL];
    [_playerController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_playerController.view];
}

@end
