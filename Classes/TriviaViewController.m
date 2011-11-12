
//
//  TriviaViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "TriviaViewController.h"
#import "Trivia.h"
#import "TriviaCell.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation TriviaViewController

@synthesize venueImage, titleLabel, addressLabel, phoneLabel, questionLabel, tableView, venue, trivia, possibleAnswers, successBlock, cancelBlock;

- (void)cancelPressed
{
    cancelBlock();
}

- (IBAction)donePressed:(id)sender
{
    // TODO: perform validation logic
    Trivia* tTrivia = [possibleAnswers objectAtIndex:selectedIndex];
    if( tTrivia==trivia ) {
        successBlock(trivia, YES);
    }else{
        successBlock(trivia, NO);
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
    
    selectedIndex = -1;
    titleLabel.text = venue.name;
    addressLabel.text = venue.address;
    phoneLabel.text = venue.phone;
    questionLabel.text = trivia.question;
    
    self.navigationItem.title = @"Trivia Question";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)] autorelease];
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)] autorelease];
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
	TriviaCell* tCell = (TriviaCell*)[aTableView dequeueReusableCellWithIdentifier:sCellIdentifier];
	if( tCell==nil ) {
        NSArray* tCells = [[NSBundle mainBundle] loadNibNamed:sCellIdentifier owner:self options:nil];
		tCell = [tCells objectAtIndex:0];
	}
	
    Trivia* tTrivia = [possibleAnswers objectAtIndex:indexPath.row];
    tCell.answerText.text = tTrivia.answer;
	
    if( selectedIndex==indexPath.row ) {
        tCell.answerText.textColor = [UIColor blackColor];
        tCell.optionImage.image = [UIImage imageNamed:@"icon-trivia-selected"];
        tCell.backgroundImage.image = [UIImage imageNamed:@"trivia-cell-selected-bg"];
    }else{
        tCell.answerText.textColor = [UIColor whiteColor];
        tCell.optionImage.image = [UIImage imageNamed:@"icon-trivia-option"];
        tCell.backgroundImage.image = [UIImage imageNamed:@"trivia-cell-bg"];
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
