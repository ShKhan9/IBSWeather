//
//  downloadItem.m
//  IBSWeather
//
//  Created by ShKhan on 12/4/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import "downloadItem.h"
#import "AppDelegate.h"
#import "DataClass.h"
#import "weatherItem.h"
@implementation downloadItem


-(downloadItem*)initWithId:(NSString*)id
cityName:(NSString*)cityName
{
    
    self.id = id;
    
    self.cityName = cityName;
    
    
    return self;
    
    
}
-(void)startDownload
{
    NSURL*url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@?APPID=%@&q=%@",openWeatherMapBaseURL,openWeatherMapAPIKey,self.cityName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    NSLog(@"sdcvsdcfadsc : %@ -- %@ -- %@",openWeatherMapBaseURL,openWeatherMapAPIKey,self.cityName);
    
    [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error == nil)
        {
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary*main = json[@"main"];
            
            // NSLog(@"fasda : %@",main);
            
            NSString*humidity = [main[@"humidity"] stringValue];
            
            NSString*pressure = [main[@"pressure"] stringValue];
            
            NSString*temp = [main[@"temp"] stringValue];
            
            NSString*tempMax = [main[@"temp_max"] stringValue];
            
            NSString*tempMin = [main[@"temp_min"] stringValue];
            
            
            
            NSArray*weatherArr = json[@"weather"];
            
            NSDictionary*weather = weatherArr[0];
            
            
            NSString*description = weather[@"description"];
            
            
            NSDictionary*wind = json[@"wind"];
            
            NSString*deg = [wind[@"deg"] stringValue];
            
            NSString*speed = [wind[@"speed"] stringValue];
            
            
            NSMutableArray*wer = [[DataClass getInstance].allEgypt copy];
            
            weatherItem*current = [weatherItem new];
            
            for (int i = 0; i<wer.count; i++)
            {
                
                weatherItem*we = [[DataClass getInstance].allEgypt objectAtIndex:i];
                
                if([we.id isEqualToString:self.id])
                {
                    we.humidity = humidity;
                    we.pressure = pressure;
                    
                    double resultTemp = ( [temp doubleValue] - 273.15 ) ;
                    
                    we.temp = [NSString stringWithFormat:@"%.1f °C",resultTemp];
                    
                    double resultTempMax = ( [tempMax doubleValue] - 273.15 ) ;
                    
                    we.tempMax = [NSString stringWithFormat:@"%.1f °C",resultTempMax];
                    
                    double resultTempMin = ( [tempMin doubleValue] - 273.15 ) ;
                    
                    we.tempMin = [NSString stringWithFormat:@"%.1f °C",resultTempMin];
                    
                    
                    we.humidity = humidity;
                    we.descriptions = description;
                    we.degree = deg;
                    we.speed = speed;
                    
                    current = we;
                    
                    break;
                    
                }
                
            }
            
            
            
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            
            dispatch_async(mainQueue, ^(void) {
                
                NSLog(@"opapaspaspasppassa");
                
                [DataClass getInstance].allEgypt = wer;
                
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"refreshDataYaCities"
                 object:current
                 ];
                
            });
            
          
            
            NSLog(@"dasdasddasdata : %@",json);
        }
        else
        {
            NSLog(@"dasdasddasdata : %@",error);
        }
        
        
    }].resume;
    
}

-(void)start
{
    NSURL*url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@?APPID=%@&q=%@",openWeatherMapBaseURL,openWeatherMapAPIKey,self.cityName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             
             NSLog(@"respo is : %@",json);
             
             if(json!=nil)
             {
                 NSDictionary*main = json[@"main"];
                 
                 // NSLog(@"fasda : %@",main);
                 
                 NSString*humidity = main[@"humidity"];
                 
                 NSString*pressure = main[@"pressure"];
                 
                 NSString*temp = main[@"temp"];
                 
                 NSString*tempMax = main[@"temp_max"];
                 
                 NSString*tempMin = main[@"temp_min"];
                 
                 
                 
                 NSArray*weatherArr = json[@"weather"];
                 
                 NSDictionary*weather = weatherArr[0];
                 
                 
                 NSString*description = weather[@"description"];
                 
                 
                 NSDictionary*wind = json[@"wind"];
                 
                 NSString*deg = wind[@"deg"];
                 
                 NSString*speed = wind[@"speed"];
                 
                 
                 NSMutableArray*wer = [[DataClass getInstance].allEgypt copy];
                 
                 for (int i = 0; i<wer.count; i++)
                 {
                     
                     weatherItem*we = [[DataClass getInstance].allEgypt objectAtIndex:i];
                     
                     if([we.id isEqualToString:self.id])
                     {
                         we.humidity = humidity;
                         we.pressure = pressure;
                         we.temp = temp;
                         we.tempMax = tempMax;
                         we.humidity = humidity;
                         we.tempMin = tempMin;
                         we.descriptions = description;
                         we.degree = deg;
                         we.speed = speed;
                         
                         break;
                         
                     }
                     
                 }
                 
                 [DataClass getInstance].allEgypt = wer;
                 
                 [[NSNotificationCenter defaultCenter]
                  postNotificationName:@"refreshDataYaCities"
                  object:nil
                  ];
                 
                 
                 
                     dispatch_queue_t mainQueue = dispatch_get_main_queue();
                     
                     dispatch_async(mainQueue, ^(void) {
                         
                         
                     });
                   
                 
             }
             else
             {
                 NSLog(@"nil Dic ");
             }
             
         }
         else
         {
             NSLog(@"error dd : %@",error);
             
             
         }
         
     }];
    
}

@end
