//
//  MapViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Hop.h"


@interface MapViewController : UIViewController <MKMapViewDelegate> {
    
    IBOutlet MKMapView* mapView;

    Hop* hop;
    
}

@property (retain) MKMapView* mapView;
@property (retain) Hop* hop;

@end
