//
//  HopViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "HopViewController.h"
#import "Venue.h"
#import "VenueViewController.h"
#import "Checkin.h"
#import "Assignment.h"
#import "MapViewController.h"
#import "VenueCell.h"
#import "BrandedNavigationController.h"
#import "LocationManager.h"
#import "ImageManager.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation HopViewController

@synthesize imageView, titleLabel, descriptionLabel, tableView, startButton, progressLabel, progressView, hop, active;

- (IBAction)startThisHop:(id)sender
{
    [self showHud:@"Starting"];
    Assignment* tAssignment = [[[Assignment alloc] init] autorelease];
    tAssignment.hopId = hop.hopId;
    [[RKObjectManager sharedManager] postObject:tAssignment delegate:self];
}

- (IBAction)showMap:(id)sender
{
    MapViewController* tMapView = [[[MapViewController alloc] init] autorelease];
    tMapView.hop = hop;
    BrandedNavigationController* tNav = [[[BrandedNavigationController alloc] initWithRootViewController:tMapView] autorelease];
    [self.navigationController presentModalViewController:tNav animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // configure state-dependent component visibility
    startButton.hidden = active;
    
    // populate UI
    titleLabel.text = hop.title;
    progressView.hidden = YES;
    progressLabel.hidden = YES;
    
    [[ImageManager sharedManager] loadImageNamed:hop.imageUrl 
                                    successBlock:^(UIImage* aImage) {
                                        async_main(^{ imageView.image = aImage; });
                                    }
                                    failureBlock:^{
                                        async_main(^{ imageView.image = [UIImage imageNamed:@"hop-image"]; });
                                    }];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [LocationManager sharedManager].delegate = self;
    [[LocationManager sharedManager] startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [LocationManager sharedManager].delegate = nil;
    [[LocationManager sharedManager] stopUpdatingLocation];
}

#pragma mark -
#pragma mark UITableView Datasource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	return hop.venues.count;
}

- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* sCellIdentifier = @"VenueCell";
	VenueCell* tCell = (VenueCell*)[aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
        NSArray* tCells = [[NSBundle mainBundle] loadNibNamed:@"VenueCell" owner:self options:nil];
		tCell = [tCells objectAtIndex:0];
	}
	
	Venue* tVenue = [hop.venues objectAtIndex:indexPath.row];
    CLLocation* tVenueLocation = [[[CLLocation alloc] initWithLatitude:[tVenue.lat doubleValue] longitude:[tVenue.lng doubleValue]] autorelease];
    CLLocationManager* tMgr = [LocationManager sharedManager];
    float tDist = [tVenueLocation distanceFromLocation:tMgr.location];
	
    tCell.titleLabel.text = tVenue.name;
    tCell.distanceLabel.text = [NSString stringWithFormat:@"%3.2f mi",tDist*3.2808/5280.0];
	
	return tCell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Venue* tVenue = [hop.venues objectAtIndex:indexPath.row];
    VenueViewController* tVenueView = [[[VenueViewController alloc] initWithNibName:@"VenueView" bundle:[NSBundle mainBundle]] autorelease];
    tVenueView.venue = tVenue;
    [self.navigationController pushViewController:tVenueView animated:YES];

    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
//    HopViewController* tHopView = [[[HopViewController alloc] initWithNibName:@"HopView" bundle:[NSBundle mainBundle]] autorelease];
//    tHopView.hop = tHop;
//    
//    [self.navigationController pushViewController:tHopView animated:YES];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    [self hideHud];
    DDLogVerbose(@"HopView - object loaded: %@",object);
    
    Assignment* tAssignment = (Assignment*)object;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AssignmentCreated" object:tAssignment];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    [self hideHud];
    Alert(@"Unable to add hop", [error localizedDescription]);
    DDLogWarn([error localizedDescription]);
//    if( error.code==1004 ) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionDestroyed" object:nil];
//    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    async_main(^{ [tableView reloadData]; });
}

@end
