//
//  HopListViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "AssignmentListViewController.h"
#import "Hop.h"
#import "User.h"
#import "AssignmentViewController.h"
#import "Assignment.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation AssignmentListViewController

@synthesize modeSelect, tableView, hops, allHops;

- (void)refreshHops
{
    [self showHud:@"Loading"];
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/user/assignments" delegate:self];
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
    for (Assignment* assignment in self.allHops) {
        if( [assignment.complete boolValue]==aComplete ) {
            [tHops addObject:assignment];
        }
    }
    self.hops = tHops;
}

- (void)checkinSuccessful:(NSNotification*)notif
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES]; 
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self refreshHops];
    });
}

- (void)trophyAwarded:(NSNotification*)notif
{
    dispatch_async(dispatch_get_main_queue(), ^{
        Alert(@"TODO", @"trophy awarded");
    });
}

- (void)assignmentDeleted:(NSNotification*)notif
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self refreshHops];
    });
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

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(checkinSuccessful:)
                                                 name:@"CheckinSuccessful"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(trophyAwarded:)
                                                 name:@"TrophyAwarded"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshHops) 
                                                 name:@"AssignmentCreated"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(assignmentDeleted:) 
                                                 name:@"AssignmentDeleted"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
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
	
	Assignment* tAssignment = [hops objectAtIndex:indexPath.row];
    Hop* tHop = tAssignment.hop;
	tCell.textLabel.text = tHop.title;
	tCell.detailTextLabel.text = [NSString stringWithFormat:@"%d places, %d points",tHop.venues.count,[tHop.points intValue]];
	
	return tCell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( editingStyle==UITableViewCellEditingStyleDelete ) {
        [self showHud:@"Deleting"];
        Assignment* tAssignment = [hops objectAtIndex:indexPath.row];
        [[RKObjectManager sharedManager] deleteObject:tAssignment delegate:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Assignment* tAssignment = [hops objectAtIndex:indexPath.row];
    AssignmentViewController* tHopView = [[[AssignmentViewController alloc] initWithNibName:@"HopView" bundle:[NSBundle mainBundle]] autorelease];
    tHopView.hop = tAssignment.hop;
    tHopView.assignment = tAssignment;
    
    [self.navigationController pushViewController:tHopView animated:YES];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    [self hideHud];
	DDLogVerbose(@"AssignmentListView - objects loaded: %@",objects);
    if( [objectLoader isDELETE] ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AssignmentDeleted" object:nil];
    }else if( [objectLoader isGET] ) {
        self.allHops = objects;
        BOOL tComplete = [modeSelect selectedSegmentIndex]==1;
        [self showHops:tComplete];
        
        dispatch_async(dispatch_get_main_queue(), ^{ 
            [tableView reloadData];
        });
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    [self hideHud];
	DDLogVerbose(@"AssignmentListView - object loaded: %@",object);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    [self hideHud];
	DDLogWarn(@"Encountered an error: %@", error);
    Alert(@"Unable to load", [error localizedDescription]);
//    if( error.code==1004 ) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionDestroyed" object:nil];
//    }
}

#pragma mark -

- (void)dealloc 
{
	[hops release];
    [tableView release];
    [super dealloc];
}


@end
