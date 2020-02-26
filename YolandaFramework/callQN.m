//
//  callQN.m
//  YolandaFramework
//
//  Created by Tomoaki Nishioka on 2020/02/17.
//  Copyright © 2020 Tomoaki Nishioka. All rights reserved.
//

#import "callQN.h"
#import "QNDeviceSDK.h"

@implementation callQN

- (void) initializeQNBleApi{
    NSLog(@"initializeQNBleApi");
    QNBleApi.debug = YES;
    NSString *file = [[NSBundle mainBundle] pathForResource:@"upswell20190514" ofType:@"qn"];
    [[QNBleApi sharedBleApi] initSdk:@"upswell20190514" firstDataFile:file callback:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

@end
