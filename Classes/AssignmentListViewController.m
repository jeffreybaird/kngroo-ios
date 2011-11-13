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
#import "AssignmentCell.h"
#import "ImageManager.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation AssignmentListViewController

@synthesize modeSelect, tableView, hops, allHops;

- (void)toggleEditMode
{
    if( tableView.editing ) {
        tableView.editing = NO;
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditMode)] autorelease];
    }else{
        tableView.editing = YES;
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleEditMode)] autorelease];
    }
}

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
    async_main(^{ [self.navigationController popToRootViewControllerAnimated:YES]; });
    async_global(^{ [self refreshHops]; });
}

- (void)trophyAwarded:(NSNotification*)notif
{
    async_main(^{ Alert(@"TODO", @"trophy awarded"); });
}

- (void)assignmentDeleted:(NSNotification*)notif
{
    async_global(^{ [self refreshHops]; });
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	// refresh hops
	[self refreshHops];

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditMode)] autorelease];
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
	static NSString* sCellIdentifier = @"AssignmentCell";
	AssignmentCell* tCell = (AssignmentCell*)[tableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
        NSArray* tCells = [[NSBundle mainBundle] loadNibNamed:@"AssignmentCell" owner:self options:nil];
		tCell = [tCells objectAtIndex:0];
	}
	
	Assignment* tAssignment = [hops objectAtIndex:indexPath.row];
    Hop* tHop = tAssignment.hop;
    [[ImageManager sharedManager] loadImageNamed:tHop.imageUrl
                                    successBlock:^(UIImage* aImage) {
                                        async_main(^{ tCell.imageView.image = aImage; });
                                    }
                                    failureBlock:^{
                                        async_main(^{ tCell.imageView.image = [UIImage imageNamed:@"hop-image"]; });
                                    }];
	tCell.titleLabel.text = tHop.title;
    tCell.progressView.progress = (float)tAssignment.checkins.count / (float)tAssignment.hop.venues.count;
    tCell.progressLabel.text = [NSString stringWithFormat:@"%d / %d",tAssignment.checkins.count,tAssignment.hop.venues.count];
	
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
    AssignmentViewController* tHopView = [[[AssignmentViewController alloc] initWithNibName:@"AssignmentView" bundle:[NSBundle mainBundle]] autorelease];
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
        
        async_main(^{ [tableView reloadData]; });
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
