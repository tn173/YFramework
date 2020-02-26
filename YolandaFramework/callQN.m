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

@end
