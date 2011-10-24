//
//  HopListViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "HopListViewController.h"
#import "Hop.h"
#import "HopViewController.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation HopListViewController

@synthesize modeSelect, tableView, hops, allHops;

- (void)refreshHops
{
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/hops" delegate:self];
}

- (void)modeChanged
{
    BOOL tComplete = [modeSelect selectedSegmentIndex]==1;
    [self showHops:tComplete];
    [tableView reloadData];
}

- (void)showHops:(BOOL)aComplete
{
    NSMutableArray* tHops = [NSMutableArray array];
    for (Hop* hop in self.allHops) {
//        if( [hop.featured boolValue]==aComplete ) {
            [tHops addObject:hop];
//        }
    }
    self.hops = tHops;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	// refresh hops
	[self refreshHops];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshHops)] autorelease];    
    
    [modeSelect addTarget:self action:@selector(modeChanged) forControlEvents:UIControlEventValueChanged];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	return hops.count;
}

- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* sCellIdentifier = @"HopListCell";
	UITableViewCell* tCell = [aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
		tCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sCellIdentifier] autorelease];
	}
	
	Hop* tHop = [hops objectAtIndex:indexPath.row];
	tCell.textLabel.text = tHop.title;
	tCell.detailTextLabel.text = [NSString stringWithFormat:@"%d places, %d points",tHop.venues.count,[tHop.points intValue]];
	
	return tCell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Hop* tHop = [hops objectAtIndex:indexPath.row];
    HopViewController* tHopView = [[[HopViewController alloc] initWithNibName:@"HopView" bundle:[NSBundle mainBundle]] autorelease];
    tHopView.hop = tHop;
    tHopView.active = NO;
    
    [self.navigationController pushViewController:tHopView animated:YES];
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
	DDLogVerbose(@"objects loaded: %@",objects);
    self.allHops = objects;
    BOOL tComplete = [modeSelect selectedSegmentIndex]==1;
    [self showHops:tComplete];
    
	dispatch_async(dispatch_get_main_queue(), ^{ 
		[self.tableView reloadData];
	});
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
	DDLogVerbose(@"object loaded: %@",object);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
	DDLogVerbose(@"Encountered an error: %@", error);
    Alert(@"Unable to load", [error localizedDescription]);
}



@end
