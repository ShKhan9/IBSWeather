//
//  weatherItem.m
//  IBSWeather
//
//  Created by ShKhan on 3/12/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import "weatherItem.h"

@implementation weatherItem


-(weatherItem*)initWithId:(NSString*)id
name:(NSString*)name country:(NSString*)country lat:( NSString*)lat lon:( NSString*)lon
{
    
    self.id = id;
    
    self.name = name;
    
    self.country = country;
    
    self.lat = lat;
    
    self.lon = lon;
    
    
    return  self;
}
 
@end
