//
//  DataClass.m
//  PrayerNow
//
//  Created by ApprocksEg on 11/2/15.
//  Copyright © 2015 ApprocksEg. All rights reserved.
//

#import "DataClass.h"
#import <SystemConfiguration/SystemConfiguration.h>
@implementation DataClass

static DataClass *instance = nil;

+(DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataClass new];
            
            NSUserDefaults*defaults = [NSUserDefaults  standardUserDefaults];
            
            NSString* dd = NSLocalizedString(@"appLang", comment: "");
            
            if([dd isEqualToString:@"ar"])
            {
                instance.ar = YES ;
                
                [defaults setObject:@[dd] forKey:@"AppleLanguages"];
            }
            else
            {
                instance.ar = NO ;
                
                [defaults setObject:@[dd] forKey:@"AppleLanguages"];
            }
            
            
            instance.leftArrow = [NSString stringWithFormat:@"%C",0xf104];
            instance.rightArrow = [NSString stringWithFormat:@"%C",0xf105];
            
            instance.allEgypt = [NSMutableArray new];
        }
    }
    
    return instance;
}

+(bool)isNetworkAvailable {
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    
    CFRelease (dReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is Available");
        
        return YES;
    }
    else
    {
        NSLog (@"Connection is down");
        
        return NO;
    }
}

/*
+(bool)isNetworkAvailable {
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef address;
    address = SCNetworkReachabilityCreateWithName(NULL, "www.apple.com");
    Boolean success = SCNetworkReachabilityGetFlags(address, &flags);
    CFRelease(address);
    bool canReach = success
    && !(flags & kSCNetworkReachabilityFlagsConnectionRequired)
    && (flags & kSCNetworkReachabilityFlagsReachable);
    
    return canReach;
}
*/
@end
