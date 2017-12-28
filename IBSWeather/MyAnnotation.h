//
//  MyAnnotation.h
//  PrayerNow
//
//  Created by ApprocksEg on 1/10/16.
//  Copyright © 2016 ApprocksEg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "weatherItem.h"
@interface MyAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;
 @property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) weatherItem *weatherItem;
@property (nonatomic, unsafe_unretained) MKPinAnnotationColor pinColor;
- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                            subTitle:(NSString *)paramSubTitle id:(NSString *)id weatherItem:(weatherItem *)weatherItem;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates ;

+ (NSString *) reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor;
@end
