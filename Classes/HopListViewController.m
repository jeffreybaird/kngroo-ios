//
//  HopListViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "HopListViewController.h"
#import "Hop.h"
#import "User.h"
#import "HopViewController.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation HopListViewController

@synthesize modeSelect, tableView, hops, allHops;

- (void)refreshHops
{
//	RKObjectMapping* tHopMapping = [RKObjectMapping mappingForClass:[Hop class]];
//	[tHopMapping mapKeyPath:@"id" toAttribute:@"hopId"];
//	[tHopMapping mapKeyPath:@"title" toAttribute:@"title"];
//	[tHopMapping mapKeyPath:@"points" toAttribute:@"points"];

	// grab server data for this app
//	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/hops" objectMapping:tHopMapping delegate:self];
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/user/hops" delegate:self];
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
        if( [hop.completed boolValue]==aComplete ) {
            [tHops addObject:hop];
        }
    }
    self.hops = tHops;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	// refresh hops
	[self refreshHops];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshHops)] autorelease];    
    
    [modeSelect addTarget:self action:@selector(modeChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UITableView Datasource and Delegate

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
	UITableViewCell* tCell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
		tCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sCellIdentifier] autorelease];
	}
	
	Hop* tHop = [hops objectAtIndex:indexPath.row];
	tCell.textLabel.text = tHop.title;
	tCell.detailTextLabel.text = [NSString stringWithFormat:@"%d places, %d points",tHop.venues.count,[tHop.points intValue]];
	
	return tCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hop* tHop = [hops objectAtIndex:indexPath.row];
    HopViewController* tHopView = [[[HopViewController alloc] initWithNibName:@"HopView" bundle:[NSBundle mainBundle]] autorelease];
    tHopView.hop = tHop;
    
    [self.navigationController pushViewController:tHopView animated:YES];
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
		[tableView reloadData];
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

#pragma mark -

- (void)dealloc 
{
	[hops release];
    [tableView release];
    [super dealloc];
}


@end
