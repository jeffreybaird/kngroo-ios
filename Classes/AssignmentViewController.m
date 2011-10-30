//
//  AssignmentViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/24/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "AssignmentViewController.h"
#import "Venue.h"
#import "Checkin.h"
#import "VenueViewController.h"


@implementation AssignmentViewController

@synthesize assignment;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    startButton.hidden = self.assignment!=nil;
    descriptionLabel.text = assignment.hop.summary;
    
    progressLabel.text = [NSString stringWithFormat:@"Progress (%d of %d):",assignment.checkins.count,hop.venues.count];
    progressView.progress = (float)assignment.checkins.count / (float)hop.venues.count;
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
#pragma mark UITableView methods

- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* sCellIdentifier = @"HopListCell";
	UITableViewCell* tCell = [aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
		tCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sCellIdentifier] autorelease];
	}
	
	Venue* tVenue = [hop.venues objectAtIndex:indexPath.row];
	
    tCell.textLabel.text = tVenue.name;
	
    BOOL tVenueCheckedIn = NO;
    for (Checkin* checkin in assignment.checkins) {
        if( [checkin.venueId intValue]==[tVenue.venueId intValue] ) {
            tVenueCheckedIn = YES;
            break;
        }
    }
    if( tVenueCheckedIn ) {
        tCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        tCell.accessoryType = UITableViewCellAccessoryNone;
    }

    return tCell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Venue* tVenue = [hop.venues objectAtIndex:indexPath.row];
    VenueViewController* tVenueView = [[[VenueViewController alloc] initWithNibName:@"VenueView" bundle:[NSBundle mainBundle]] autorelease];
    tVenueView.venue = tVenue;
    tVenueView.assignment = assignment;
    
    [self.navigationController pushViewController:tVenueView animated:YES];
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    //    HopViewController* tHopView = [[[HopViewController alloc] initWithNibName:@"HopView" bundle:[NSBundle mainBundle]] autorelease];
    //    tHopView.hop = tHop;
    //    
    //    [self.navigationController pushViewController:tHopView animated:YES];
}


@end
