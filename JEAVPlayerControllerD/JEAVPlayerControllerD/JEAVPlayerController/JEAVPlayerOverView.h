//
//  asdsd.h
//  JEAVPlayerControllerD
//
//  Created by 李佳佳 on 16/6/30.
//  Copyright © 2016年 李佳佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEAVPlayerProtocol.h"


@interface JEAVPlayerOverView : UIView <JEAVPlayerProtocol>
@property(nonatomic,weak)id<JEAVPlayerControllerDelegate>delegate;
@end
