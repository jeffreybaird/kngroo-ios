//
//  AccountViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/26/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "AccountViewController.h"
#import "Trophy.h"
#import "Session.h"


@implementation AccountViewController

@synthesize modeSelect, personalView, tableView, user;

- (void)refreshUser
{
    [self showHud:@"Loading"];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/user" delegate:self];
}

- (void)signOutPressed
{
    UIActionSheet* tAction = [[[UIActionSheet alloc] initWithTitle:@"Confirm sign out?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Sign Out" otherButtonTitles:nil] autorelease];
    [tAction showFromTabBar:self.navigationController.tabBarController.tabBar];
}

- (void)trophyAwarded:(NSNotification*)notif
{
    [self refreshUser];
}

- (void)modeChanged
{
    int tTrophyVisible = [modeSelect selectedSegmentIndex]==1;
    personalView.hidden = tTrophyVisible;
    tableView.hidden = !tTrophyVisible;
    
    if( user ) {
        emailLabel.text = user.email;
        pointsLabel.text = [NSString stringWithFormat:@"%@",user.points];
        trophiesLabel.text = [NSString stringWithFormat:@"%d",user.trophies.count];
    }
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];

	// refresh user
	[self refreshUser];
    
    [modeSelect addTarget:self action:@selector(modeChanged) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOutPressed)] autorelease];    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshUser)] autorelease];    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(trophyAwarded:)
                                                 name:@"TrophyAwarded"
                                               object:nil];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return user.trophies.count;
}

- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* sCellIdentifier = @"TrophyCell";
	UITableViewCell* tCell = [aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
		tCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sCellIdentifier] autorelease];
	}
	
	Trophy* tTrophy = [user.trophies objectAtIndex:indexPath.row];
	tCell.textLabel.text = tTrophy.hop.title;
	tCell.detailTextLabel.text = [NSString stringWithFormat:@"awarded %@",tTrophy.createdAt];
	
	return tCell;
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    [self hideHud];
    if( [object isKindOfClass:[User class]] ) {
        User* tUser = (User*)object;
        self.user = tUser;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self modeChanged];
        });
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionDestroyed" object:nil];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if( buttonIndex==0 ) {
        [self showHud:@"Signing Out"];
        Session* tSession = [[[Session alloc] init] autorelease];
        [[RKObjectManager sharedManager] deleteObject:tSession delegate:self];
    }
}

@end
