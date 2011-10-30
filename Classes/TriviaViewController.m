
//
//  TriviaViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "TriviaViewController.h"
#import "Trivia.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation TriviaViewController

@synthesize questionLabel, tableView, trivia, possibleAnswers, successBlock, cancelBlock;

- (void)cancelPressed
{
    cancelBlock();
}

- (void)donePressed
{
    // TODO: perform validation logic
    successBlock(YES);
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
    
    selectedIndex = -1;
    questionLabel.text = trivia.question;
    
    self.navigationItem.title = @"Trivia Question";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)] autorelease];
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
    return possibleAnswers.count;
}

- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* sCellIdentifier = @"TriviaCell";
	UITableViewCell* tCell = [aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
		tCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sCellIdentifier] autorelease];
	}
	
    Trivia* tTrivia = [possibleAnswers objectAtIndex:indexPath.row];
    tCell.textLabel.text = tTrivia.answer;
	
    if( selectedIndex==indexPath.row ) {
        tCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        tCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return tCell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    [aTableView reloadData];
}

@end
