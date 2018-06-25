//
//  LaunchMovieVW.m
//  GeneralExample
//
//  Created by pxh on 2018/5/18.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import "LaunchMovieVW.h"

@interface LaunchMovieVW()

@property(nonatomic,strong)NSTimer* timer;

@property(nonatomic,assign)int time;

@property(nonatomic,strong)UILabel* label;

@end

@implementation LaunchMovieVW

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _time = 3;
        [self configureLaunchMovie];
        return self;
    }
    return nil;
}

- (void)configureLaunchMovie{
    [self setBackgroundColor:[UIColor purpleColor]];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:true];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    _label.text = [[[NSNumber alloc] initWithInt:_time] stringValue];
    _label.center = self.center;
    [self addSubview:_label];
}

- (void)timerAction:(NSTimer* )timer{
    self.time -= 1;
    if (_time < 0) {
        [_timer invalidate];
        [self removeFromSuperview];
    }
}

- (void)setTime:(int)time{
    _time = time;
    _label.text = [[[NSNumber alloc] initWithInt:_time] stringValue];
}

@end
