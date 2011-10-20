//
//  AllHopListViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "AllHopListViewController.h"
#import "Hop.h"
#import "HopViewController.h"


@implementation AllHopListViewController

- (void)refreshHops
{
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/hops" delegate:self];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hop* tHop = [hops objectAtIndex:indexPath.row];
    HopViewController* tHopView = [[[HopViewController alloc] initWithNibName:@"HopView" bundle:[NSBundle mainBundle]] autorelease];
    tHopView.hop = tHop;
    tHopView.active = NO;
    
    [self.navigationController pushViewController:tHopView animated:YES];
}



@end
