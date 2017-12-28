//
//  downloadItem.h
//  IBSWeather
//
//  Created by ShKhan on 12/4/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface downloadItem : NSObject


@property (nonatomic,strong)  NSString*id;

@property (nonatomic,strong)  NSString*cityName;


-(downloadItem*)initWithId:(NSString*)id
cityName:(NSString*)cityName;

-(void)startDownload;
-(void)start;

@end




