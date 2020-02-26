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

- (void) initializeBleApi{
    NSLog(@"initializeBleApi");
    QNConfig *config = [[QNBleApi sharedBleApi] getConfig];
    [config setShowPowerAlertKey:NO];
    [config setUnit:QNUnitKG];
    [config setOnlyScreenOn:true];

    _bleApi = [QNBleApi sharedBleApi];
    _bleApi.discoveryListener = self;
    _bleApi.dataListener = self;

    NSString *dateBirth = @"2000/01/01";
    NSString* dateString = [NSString stringWithFormat:@"%@ 00:00:00",dateBirth];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    NSDate *date = [formatter dateFromString:dateString];
    int height = 170;
    NSString *gender = @"male";
        self.user = [self.bleApi buildUser:@"upswell20190514" height:height gender:gender birthday:date callback:^(NSError *error) {
        NSLog( @"%@", error );
    }];
}

- (void) startBleDeviceDiscovery{
    [_bleApi startBleDeviceDiscovery:^(NSError *error) {
        NSLog(@"startBleDeviceDiscovery!");
        if (error) {
            NSLog( @"%@", error );
           }
    }];
}

- (void) stopBleDeviceDiscorvery{
    [_bleApi stopBleDeviceDiscorvery:^(NSError *error) {
        NSLog(@"stopBleDeviceDiscorvery!");
    }];
}

- (void)onDeviceDiscover:(QNBleDevice *)device {
    NSLog(@"onDeviceDiscover!");
    [self.bleApi connectDevice:device user:_user callback:^(NSError *error) {
        NSLog( @"%@", error );
    }];
}

- (void)onBroadcastDeviceDiscover:(QNBleBroadcastDevice *)device {
    NSLog(@"onBroadcastDeviceDiscover!");
}

- (void)onStartScan {
    NSLog(@"onStartScan!");
}

- (void)onStopScan {
    NSLog(@"onStopScan!");
}

- (void)onConnecting:(QNBleDevice *)device {
    // Start the connection callback
     NSLog(@"onConnecting!");
}

- (void)onConnected:(QNBleDevice *)device {
    //Connected successfully callback
    NSLog(@"onConnected!");
}

- (void)onServiceSearchComplete:(QNBleDevice *)device {
    // Found the service completion callback
    NSLog(@"onServiceSearchComplete!");
}

- (void)onDisconnecting:(QNBleDevice *)device {
    //Disconnecting callbacks
    NSLog(@"onDisconnecting!");
}

- (void)onConnectError:(QNBleDevice *)device error:(NSError *)error {
    //Connection failed callback
    NSLog(@"onConnectError!");
}

- (void)onGetUnsteadyWeight:(QNBleDevice *)device weight:(double)weight {
    NSLog(@"onGetUnsteadyWeight!");
}

- (void)onGetScaleData:(QNBleDevice *)device data:(QNScaleData *)scaleData {
    NSLog(@"onGetScaleData!");
    for (QNScaleItemData *item in [scaleData getAllItem]) {
        if (item.type == QNScaleTypeWeight && item.value != 0) {
            NSLog(@"weight = %f",item.value);
        }
        else if (item.type == QNScaleTypeBodyFatRate) {
            NSLog(@"bodyFat = %f",item.value);
        }
        else if (item.type == QNScaleTypeBodyWaterRate) {
            NSLog(@"waterPercentage = %f",item.value);
        }
        else if (item.type == QNScaleTypeMuscleMass) {
            NSLog(@"QNScaleTypeMuscleMass = %f",item.value);
        }

        else if (item.type == QNScaleTypeBoneMass) {
            NSLog(@"QNScaleTypeBoneMass = %f",item.value);
        }
        else if (item.type == QNScaleTypeBMI) {
            NSLog(@"QNScaleTypeBMI = %f",item.value);
        }
        else if (item.type == QNScaleTypeVisceralFat) {
            NSLog(@"QNScaleTypeVisceralFat = %f",item.value);
        }
    }
    
    [_bleApi stopBleDeviceDiscorvery:^(NSError *error) {
        NSLog( @"%@", error );
    }];
}


- (void)onGetStoredScale:(QNBleDevice *)device data:(NSArray <QNScaleStoreData *> *)storedDataList {
    NSLog(@"onGetStoredScale!");
    
}

- (void)onGetElectric:(NSUInteger)electric device:(QNBleDevice *)device {
    NSLog(@"onGetElectric!");
}


@end
