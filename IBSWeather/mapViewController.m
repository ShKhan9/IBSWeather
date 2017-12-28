//
//  mainViewController.m
//  IBSWeather
//
//  Created by ShKhan on 12/3/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import "mapViewController.h"
#import "weatherItem.h"
#import "DataClass.h"
#import "MyAnnotation.h"
#import "AppDelegate.h"
#import "downloadItem.h"
#import "detailsPopViewController.h"

@interface mapViewController ()
{

    
    NSString*filePath;
    
    NSString*zipPath;
    
}

@property (nonatomic, strong) CLLocationManager *myLocationManager;
;

@property (nonatomic, strong) NSMutableArray * allDownloads;

@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"refreshDataYaCities"
                                               object:nil];
    
    self.allDownloads = [NSMutableArray new];
    
    self.myMapView.delegate = self;
    
    
    self.myMapView.showsUserLocation=YES;
    
    
    self.myMapView.mapType = MKMapTypeStandard;
    
    
    
    
    NSError*error=nil;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/Application Support"];
    
    filePath = [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"myMadfa3"]];
    
    zipPath = [[NSBundle mainBundle]pathForResource:@"allCities.json" ofType: @"zip"];
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:filePath])
    {
        if(
           
           [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:&error])
        {
            NSLog(@"created myMadfa3");
        }
        else
        {
            NSLog(@"not created myMadfa3");
        }
    }
    else
    {
        NSLog(@"myMadfa3 folder exists");
    }
    
    
    
    
    /*  ZipArchive *zipArchive = [[ZipArchive alloc] init];
     
     [zipArchive UnzipOpenFile:zipPath Password:@""];
     
     [zipArchive UnzipFileTo:filePath overWrite:YES];
     
     [zipArchive UnzipCloseFile];
     
     
     NSData*data=[NSData dataWithContentsOfFile:[filePath stringByAppendingPathComponent:@"allCities.json"]];
     
     
     // NSLog(@"data is : %@",aa);
     
     NSArray *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
     
     //  NSLog(@"responseDict : %@",responseDict);
     
     NSMutableArray*allEgypts = [NSMutableArray new];
     
     for (int i =0 ; i<responseDict.count; i++) {
     
     NSDictionary*dic = responseDict[i];
     
     //    NSLog(@"EGqqqq : %@",dic[@"country"]);
     
     if([dic[@"country"] isEqualToString:@"EG"])
     {
     
     //  NSLog(@"EGq : %@",dic);
     
     [allEgypts addObject:dic];
     }
     else
     {
     
     // NSLog(@"NO");
     }
     
     
     //if(i==0)
     //    break;
     
     
     
     }
     
     NSLog(@"allEgypts : %ld",allEgypts.count);
     
     NSLog(@"allEgypts : %@",[allEgypts jsonString]);*/
    
    
    NSString*path =[[NSBundle mainBundle] pathForResource:@"allEgypt" ofType:@"json"];
    
    
    NSData*data=[NSData dataWithContentsOfFile:path];
    
    
    // NSLog(@"data is : %@",aa);
    
    NSArray *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //  NSLog(@"responseDict : %@",responseDict);
    
    NSMutableArray*alleg = [NSMutableArray new];
    
    for (int i =0 ; i<responseDict.count; i++) {
        
        NSDictionary*dic = responseDict[i];
        
        //NSLog(@"EGqqqq  %d : %@",i,dic[@"country"]);
        
        NSString*id = [dic[@"id"] stringValue];
        
        NSString*name = dic[@"name"];
        
        NSString*country = dic[@"country"];
        
        NSDictionary*coor = dic[@"coord"];
        
        NSLog(@"lattttt :%@",coor[@"lat"] );
        
        NSString* lat = coor[@"lat"] ;
        
        NSString* lon = coor[@"lon"] ;
        
        weatherItem*we = [[weatherItem alloc]initWithId:id name:name country:country lat:lat lon:lon];
        
        [alleg addObject:we];
        
    }
    
    
    [DataClass getInstance].allEgypt = alleg;
    
   // NSLog(@"allEFFFf : %@",[DataClass getInstance].allEgypt);
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.myLocationManager.headingFilter = 1;
        self.myLocationManager.delegate = self;
        [self.myLocationManager startUpdatingLocation];
        
        if ([self.myLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.myLocationManager requestWhenInUseAuthorization];
        }
        
    }else
    {
        /* Location services are not enabled.
         Take appropriate action: for instance, prompt the
         user to enable the location services */
        //NSLog(@"Location services are not enabled");
        
      /*  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:NSLocalizedString(@"drLcation", nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"langAlertOk", nil)
                                              otherButtonTitles:nil];
        
        [alert show];*/
        
    }
    
    
    
    
    for (int i = 0; i<[DataClass getInstance].allEgypt.count; i++) {
        
      
        weatherItem*cr = [[DataClass getInstance].allEgypt objectAtIndex:i];
        
        downloadItem*dw = [[downloadItem alloc]initWithId:cr.id cityName:cr.name];
        
         [self.allDownloads addObject:dw];
        
         [dw startDownload];
        
    }
    
}

-(void)receiveNotification:(NSNotification *)paramNotification
{
    
    
    if([paramNotification.name isEqualToString:@"refreshDataYaCities"])
    {
        if(paramNotification.object != nil)
        [self refresh:paramNotification.object];
    }
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
   
    //[self getDataforCity:@"Cairo"];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)refresh:(weatherItem*)we
{
    
    for (MyAnnotation*ann in self.myMapView.annotations) {
        
        if(ann == self.myMapView.userLocation)
        {
            continue;
            
        }
        if(ann.id == we.id)
        {
            [self.myMapView removeAnnotation:ann];
            
            break;
        }
        
    }
    
    CLLocation*loc= [[CLLocation alloc] initWithLatitude:[we.lat  doubleValue] longitude:[we.lon doubleValue]];
    
    NSLog(@"lat : %@  lon : %@" , we.lat,we.lon);
    
    MyAnnotation*source =
    [[MyAnnotation alloc] initWithCoordinates:loc.coordinate
                                        title:we.name
                                     subTitle:we.temp
                                           id:we.id
                                            weatherItem:we];
    
    
    source.pinColor = MKPinAnnotationColorRed;
    
    /* And eventually add it to the map */
    [self.myMapView addAnnotation:source];
    
    
    /*
    
    for (int i = 0; i<[DataClass getInstance].allEgypt.count; i++) {
        
       
        weatherItem*we = [[DataClass getInstance].allEgypt objectAtIndex:i];
        
       if(we.temp != nil)
       {
        
           CLLocation*loc= [[CLLocation alloc] initWithLatitude:[we.lat  doubleValue] longitude:[we.lon doubleValue]];
           
           NSLog(@"lat : %@  lon : %@" , we.lat,we.lon);
           
           MyAnnotation*source =
           [[MyAnnotation alloc] initWithCoordinates:loc.coordinate
                                               title:we.name
                                            subTitle:we.temp
                                            id:we.id];
           
           
           source.pinColor = MKPinAnnotationColorRed;
           
     
           //[self.myMapView addAnnotation:source];
       }
        
        
    }*/
    
}

/*-(void)viewDidAppear:(BOOL)animated
{
    
    // [self getDataforCity:@"Cairo"];
}*/

-(void)getDataforCity:(NSString*)cityName
{
    
    NSURL*url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?APPID=%@&q=%@",openWeatherMapBaseURL,openWeatherMapAPIKey,cityName]];
    
    [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error == nil)
        {
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
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
            
            
            NSLog(@"humidity %@ : ",humidity);
            NSLog(@"pressure %@ : ",pressure);
            NSLog(@"temp %@ : ",temp);
            NSLog(@"tempMax %@ : ",tempMax);
            NSLog(@"tempMin %@ : ",tempMin);
            NSLog(@"description %@ : ",description);
            NSLog(@"deg %@ : ",deg);
            NSLog(@"speed %@ : ",speed);
           
          NSLog(@"dasdasddasdataioioio : %@",json);
        }
        else
        {
            NSLog(@"dasdasddasdata : %@",error);
        }
        
        
    }].resume;
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if(annotation != _myMapView.userLocation)
    {
        
      
        
        MyAnnotation *senderAnnotation = (MyAnnotation *)annotation;
        
        NSString *defaultPinID =
        [MyAnnotation
         reusableIdentifierforPinColor:senderAnnotation.pinColor];
        pinView = (MKAnnotationView *)[_myMapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        
        pinView.canShowCallout = YES;
        
        if( senderAnnotation.pinColor == MKPinAnnotationColorRed)
        {
              NSLog(@"calllelele");
            
            
            /* Using the class method we have defined in our custom
             annotation class, we will attempt to get a reusable
             identifier for the pin we are about
             to create */
            NSString *pinReusableIdentifier =
            [MyAnnotation
             reusableIdentifierforPinColor:senderAnnotation.pinColor];
            /* Using the identifier we retrieved above, we will
             attempt to reuse a pin in the sender Map View */
            MKPinAnnotationView *annotationView = (MKPinAnnotationView *)
            [self.myMapView
             dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
            if (annotationView == nil){
                /* If we fail to reuse a pin, then we will create one */ annotationView = [[MKPinAnnotationView alloc]
                                                                                           initWithAnnotation:senderAnnotation
                                                                                           reuseIdentifier:pinReusableIdentifier];
                
                annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                  /* Make sure we can see the callouts on top of
                 each pin in case we have assigned title and/or
                 subtitle to each pin */
                [annotationView setCanShowCallout:YES];
            }
            /* Now make sure, whether we have reused a pin or not, that
             the color of the pin matches the color of the annotation */
            annotationView.pinColor = senderAnnotation.pinColor;
            
            return  annotationView;
            
           /*  UIImage *pinImage = [UIImage imageNamed:@"art1.png"];
             
             [pinView setCanShowCallout:YES];
             
             if (pinImage != nil){
             pinView.image = pinImage;
             }*/
            
        }
        
        if( senderAnnotation.pinColor == MKPinAnnotationColorGreen)
        {
            
            
            UIImage *pinImage = [UIImage imageNamed:@"final_marker.png"];
            
            
            
            if (pinImage != nil){
                pinView.image = pinImage;
                
                
                pinView.transform = CGAffineTransformScale(CGAffineTransformIdentity, .5, .5);
                
                
            }
            
            
        }
        if( senderAnnotation.pinColor == MKPinAnnotationColorPurple)
        {
            
            
            UIImage *pinImage = [UIImage imageNamed:@"blue_pin.png"];
            
            
            
            if (pinImage != nil){
                pinView.image = pinImage;
                
                
                
                pinView.contentMode = UIViewContentModeScaleAspectFill;
                pinView.clipsToBounds = YES;
                
                
                
                
            }
            
            
            
            
            
            [pinView setSelected:YES animated:YES];
            
            
        }
        
        
    }
    else
    {
        
        [_myMapView.userLocation setTitle:@"Current location"];
    }
    return pinView;
}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"select . . .");
    
    
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"deselect . . .");
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
     NSLog(@"wqwqwqwqwqw . . .");
    
    MyAnnotation*ann = view.annotation;
    
    NSLog(@"nammemmeme : %@",ann.weatherItem);
    
    [self performSegueWithIdentifier:@"showDetails" sender:ann.weatherItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showDetails"])
    {
        
        detailsPopViewController *newVC = segue.destinationViewController;
        
         newVC.we = sender;
        
        [mapViewController setPresentationStyleForSelfController:self presentingController:newVC];
    }
    
}



+ (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        
        
        
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}

- (IBAction)showAllBtsClicked:(id)sender
{
    UIViewController*vc = [self.storyboard instantiateViewControllerWithIdentifier:@"citiesView"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
