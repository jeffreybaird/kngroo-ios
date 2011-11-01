//
//  MapViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "MapViewController.h"
#import "Venue.h"


@implementation MapViewController

@synthesize mapView, hop;

- (id)init
{
    self = [super initWithNibName:@"MapView" bundle:[NSBundle mainBundle]];
    return self;
}

- (void)donePressed
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)refreshPins
{
    NSMutableArray* tPins = [NSMutableArray array];
    float latMin = 90, latMax = -90, lngMin = 180, lngMax = -180, lat = 0, lng = 0;
    for (Venue* venue in hop.venues) {
        double tLat = [venue.lat doubleValue],
            tLng = [venue.lng doubleValue];
        if( tLat>latMax ) latMax = tLat;
        if( tLat<latMin ) latMin = tLat;
        if( tLng>lngMax ) lngMax = tLng;
        if( tLng<lngMin ) lngMin = tLng;
        lat += tLat;
        lng += tLng;
    
        MKPlacemark* tPlacemark = [[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(tLat, tLng) 
                                                         addressDictionary:nil] autorelease];
        [tPins addObject:tPlacemark];
    }
    lat /= hop.venues.count;
    lng /= hop.venues.count;
    
    [mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lng), MKCoordinateSpanMake(latMax-latMin, lngMax-lngMin)) 
              animated:YES];
    [mapView removeAnnotations:mapView.annotations];
    [mapView addAnnotations:tPins];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshPins];
    
    self.navigationItem.title = @"Hop Map";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView*)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString* sViewIdentifier = @"MapPin";
    MKPinAnnotationView* tPin = (MKPinAnnotationView*)[aMapView dequeueReusableAnnotationViewWithIdentifier:sViewIdentifier];
    if( tPin==nil ) {
        tPin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:sViewIdentifier] autorelease];
    }
    tPin.annotation = annotation;
    tPin.animatesDrop = YES;
    
    return tPin;
}

@end
