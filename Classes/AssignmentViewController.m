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
#import "VenueCell.h"


@implementation AssignmentViewController

@synthesize assignment;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    startButton.hidden = self.assignment!=nil;
    descriptionLabel.text = assignment.hop.summary;
    
    progressLabel.text = [NSString stringWithFormat:@"%d / %d",assignment.checkins.count,hop.venues.count];
    progressView.progress = (float)assignment.checkins.count / (float)hop.venues.count;
    
    progressView.hidden = NO;
    progressLabel.hidden = NO;
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
    static NSString* sCellIdentifier = @"VenueCell";
	VenueCell* tCell = (VenueCell*)[aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
        NSArray* tCells = [[NSBundle mainBundle] loadNibNamed:@"VenueCell" owner:self options:nil];
		tCell = [tCells objectAtIndex:0];
	}
	
	Venue* tVenue = [hop.venues objectAtIndex:indexPath.row];
	
    tCell.titleLabel.text = tVenue.name;
    tCell.distanceLabel.text = @"-";
	
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
    tVenueView.hop = hop;
    tVenueView.assignment = assignment;
    
    [self.navigationController pushViewController:tVenueView animated:YES];
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    //    HopViewController* tHopView = [[[HopViewController alloc] initWithNibName:@"HopView" bundle:[NSBundle mainBundle]] autorelease];
    //    tHopView.hop = tHop;
    //    
    //    [self.navigationController pushViewController:tHopView animated:YES];
}


@end
