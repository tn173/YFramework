//
//  callQN.h
//  YolandaFramework
//
//  Created by Tomoaki Nishioka on 2020/02/17.
//  Copyright © 2020 Tomoaki Nishioka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNDeviceSDK.h"

NS_ASSUME_NONNULL_BEGIN

@interface callQN : NSObject

- (void) initializeQNBleApi;
- (void) initializeBleApi;
- (void) startBleDeviceDiscovery;
- (void) stopBleDeviceDiscorvery;

@property (nonatomic, strong) QNBleApi *bleApi;
@property (nonatomic, strong) QNConfig *config;
@property (nonatomic,retain) NSString *macAddress;
@property int deviceID;
@property (nonatomic, strong) QNUser *user;

@property (nonatomic, strong) NSMutableDictionary *scanDveices;

@end

NS_ASSUME_NONNULL_END
