//
//  weatherItem.h
//  IBSWeather
//
//  Created by ShKhan on 3/12/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherItem : NSObject



@property (nonatomic,strong) NSString* id;

@property (nonatomic,strong) NSString* name;

@property (nonatomic,strong) NSString* country;

@property (nonatomic,strong)  NSString*lat;

@property (nonatomic,strong)  NSString*lon;




@property (nonatomic,strong)  NSString*humidity;

@property (nonatomic,strong)  NSString*pressure;

@property (nonatomic,strong)  NSString*temp;

@property (nonatomic,strong)  NSString*tempMax;

@property (nonatomic,strong)  NSString*tempMin;

@property (nonatomic,strong)  NSString*descriptions;

@property (nonatomic,strong)  NSString*degree;

@property (nonatomic,strong)  NSString*speed;




-(weatherItem*)initWithId:(NSString*)id
                       name:(NSString*)name country:(NSString*)country lat:( NSString*)lat lon:( NSString*)lon;


@end
