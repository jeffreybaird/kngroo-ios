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


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation HopViewController

@synthesize imageView, titleLabel, descriptionLabel, tableView, startButton, progressLabel, progressView, hop, active;

- (IBAction)startThisHop:(id)sender
{
    Assignment* tAssignment = [[[Assignment alloc] init] autorelease];
    tAssignment.hopId = hop.hopId;
    [[RKObjectManager sharedManager] postObject:tAssignment delegate:self];
}

- (IBAction)showMap:(id)sender
{
    Alert(@"TODO", @"show full screen map");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // configure state-dependent component visibility
    startButton.hidden = active;
    
    // populate UI
    titleLabel.text = hop.title;
    
    self.navigationItem.title = @"Hop";
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
	static NSString* sCellIdentifier = @"HopListCell";
	UITableViewCell* tCell = [aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
		tCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sCellIdentifier] autorelease];
	}
	
	Venue* tVenue = [hop.venues objectAtIndex:indexPath.row];
	
    tCell.textLabel.text = tVenue.name;
	
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
    DDLogVerbose(@"HopView - object loaded: %@",object);
    
    Assignment* tAssignment = (Assignment*)object;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AssignmentCreated" object:tAssignment];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    Alert(@"Unable to add hop", [error localizedDescription]);
    DDLogError([error localizedDescription]);
}

@end
