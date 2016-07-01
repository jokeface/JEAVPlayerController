//
//  ViewController.m
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import "ViewController.h"
#import "AVViewController.h"
//#import "JEAVPlayerController.h"

@interface ViewController ()
//@property(nonatomic,strong)JEAVPlayerController* playerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL* assetURL= [NSURL URLWithString:@"http://mvvideo1.meitudata.com/56e93404432e71916.mp4"];
//    _playerController =[[JEAVPlayerController alloc]initWithURL:assetURL];
//    [_playerController.view setFrame:self.view.bounds];
//    
//    [self.view addSubview:_playerController.view];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    AVViewController* viewController =[[AVViewController alloc]init];
//    [self presentViewController:viewController animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
