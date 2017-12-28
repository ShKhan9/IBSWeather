//
//  MyAnnotation.m
//  PrayerNow
//
//  Created by ApprocksEg on 1/10/16.
//  Copyright © 2016 ApprocksEg. All rights reserved.
//

#import "MyAnnotation.h"
NSString *const kReusablePinRed = @"Red";
NSString *const kReusablePinGreen = @"Green";
NSString *const kReusablePinPurple = @"Purple";

@implementation MyAnnotation
- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                            subTitle:(NSString *)paramSubTitle id:(NSString *)id weatherItem:(weatherItem *)weatherItem{
    self = [super init];
    if (self != nil){
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
        _pinColor = MKPinAnnotationColorGreen;
        _id = id;
        _weatherItem = weatherItem;
    }
    return self; }

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
{
    self = [super init];
    if (self != nil){
        _coordinate = paramCoordinates;
        _pinColor = MKPinAnnotationColorGreen;
    }
    return self;
}


+ (NSString *) reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor
{
    NSString *result = nil;
    switch (paramColor){
        case MKPinAnnotationColorRed:{
            result = kReusablePinRed;
            break; }
        case MKPinAnnotationColorGreen:
        {
            result = kReusablePinGreen; break;
        }
        case MKPinAnnotationColorPurple:{
            result = kReusablePinPurple;
            break; }
    }
    return result;  
}

 

@end
