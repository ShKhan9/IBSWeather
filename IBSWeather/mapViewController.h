//
//  mapViewController.h
//  IBSWeather
//
//  Created by ShKhan on 12/3/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface mapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
 
- (IBAction)showAllBtsClicked:(id)sender;

@end
