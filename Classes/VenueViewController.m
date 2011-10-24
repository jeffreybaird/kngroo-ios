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

@synthesize imageView, titleLabel, descriptionLabel, checkInButton, hop, venue;

- (IBAction)checkIn:(id)sender
{
    Alert(@"TODO", @"check in");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titleLabel.text = venue.name;
    descriptionLabel.text = @"stuff goes here that is long enough to span at least four lines";
    checkInButton.hidden = NO;
    
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

@end
