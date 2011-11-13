//
//  LeadersViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "LeadersViewController.h"
#import "User.h"
#import "LeaderCell.h"
#import "NSString+MD5.h"
#import "ImageManager.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation LeadersViewController

@synthesize modeSelect, tableView, users;

- (void)refreshLeaders
{
    [self showHud:@"Loading"];
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/leaders" delegate:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self refreshLeaders];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshLeaders)] autorelease];    
    
//    [modeSelect addTarget:self action:@selector(modeChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    [self hideHud];
	DDLogVerbose(@"objects loaded: %@",objects);
    self.users = objects;
//    BOOL tComplete = [modeSelect selectedSegmentIndex]==1;
//    [self showHops:tComplete];
    
	dispatch_async(dispatch_get_main_queue(), ^{ 
		[tableView reloadData];
	});
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
	DDLogVerbose(@"object loaded: %@",object);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    [self hideHud];
	DDLogWarn(@"Encountered an error: %@", error);
    Alert(@"Unable to load", [error localizedDescription]);
//    if( error.code==1004 ) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionDestroyed" object:nil];
//    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeaderCell";
    
    LeaderCell *cell = (LeaderCell*)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* tCells = [[NSBundle mainBundle] loadNibNamed:@"LeaderCell" owner:self options:nil];
		cell = [tCells objectAtIndex:0];
    }
    
    User* tUser = [users objectAtIndex:indexPath.row];
    [[ImageManager sharedManager] loadImageNamed:[tUser gravatarUrl]
                                    successBlock:^(UIImage* aImage) {
                                        async_main(^{ cell.imageView.image = aImage; });
                                    }
                                    failureBlock:^{
                                        async_main(^{ cell.imageView.image = [UIImage imageNamed:@"placeholder"]; });
                                    }];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",tUser.firstName,tUser.lastName];
    cell.pointsLabel.text = [NSString stringWithFormat:@"%d points",[tUser.points intValue]];
    if( indexPath.row<5 ) {
        NSString* tFileName = [NSString stringWithFormat:@"icon-rank%02d",indexPath.row+1];
        cell.rankImage.image = [UIImage imageNamed:tFileName];
    }else{
        cell.rankImage.image = nil;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
