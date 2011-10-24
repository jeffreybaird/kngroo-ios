//
//  VenueViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/23/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "VenueViewController.h"
#import "Checkin.h"


@implementation VenueViewController

@synthesize imageView, titleLabel, descriptionLabel, checkInButton, checkedInLabel, hop, venue, assignment;

- (IBAction)checkIn:(id)sender
{
//    NSString* tMsg = [NSString stringWithFormat:@"check in to assignment %d, venue %d",[assignment.assignmentId intValue],[venue.venueId intValue]];
//    Alert(@"TODO", tMsg);
    
    Checkin* tCheckin = [[[Checkin alloc] init] autorelease];
    tCheckin.assignmentId = assignment.assignmentId;
    tCheckin.venueId = venue.venueId;
    [[RKObjectManager sharedManager] postObject:tCheckin delegate:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titleLabel.text = venue.name;
    descriptionLabel.text = @"stuff goes here that is long enough to span at least four lines";

    if( assignment==nil ) {
        checkedInLabel.hidden = YES;
        checkInButton.hidden = YES;
    }else{
        checkInButton.hidden = NO;
        for (Checkin* checkin in assignment.checkins) {
            if( [checkin.venueId intValue]==[venue.venueId intValue] ) {
                checkedInLabel.text = [NSString stringWithFormat:@"Checked In: %@",checkin.createdAt];
                checkInButton.hidden = YES;
                break;
            }
        }
    }

    self.navigationItem.title = @"Venue";
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
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    Checkin* tCheckin = (Checkin*)object;
    NSMutableArray* tCheckins = [NSMutableArray arrayWithArray:assignment.checkins];
    [tCheckins addObject:tCheckin];
    assignment.checkins = [NSArray arrayWithArray:tCheckins];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckinSuccessful" object:nil];
    if( [tCheckin.trophyAwarded boolValue] ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TrophyAwarded" object:nil];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    Alert(@"Unable to checkin", [error localizedDescription]);
}

@end
