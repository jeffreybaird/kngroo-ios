//
//  VenueViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/23/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "VenueViewController.h"
#import "Checkin.h"
#import "TriviaViewController.h"
#import "Attempt.h"


@implementation VenueViewController

@synthesize imageView, titleLabel, descriptionLabel, checkInButton, checkedInLabel, hop, venue, assignment;

- (IBAction)showTrivia:(id)sender
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/user/assignments/%@/venues/%@/trivias",assignment.assignmentId,venue.venueId] delegate:self];
}

- (void)checkIn
{
    Checkin* tCheckin = [[[Checkin alloc] init] autorelease];
    tCheckin.assignmentId = assignment.assignmentId;
    tCheckin.venueId = venue.venueId;
    [[RKObjectManager sharedManager] postObject:tCheckin delegate:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titleLabel.text = venue.name;
    descriptionLabel.text = venue.summary;

    if( assignment==nil ) {
        checkedInLabel.hidden = YES;
        checkInButton.hidden = YES;
    }else{
        checkInButton.hidden = NO;
        for (Checkin* checkin in assignment.checkins) {
            if( [checkin.venueId intValue]==[venue.venueId intValue] ) {
                checkedInLabel.text = [NSString stringWithFormat:@"Checked In: %@",checkin.createdAt];
                checkInButton.hidden = YES;
                break;
            }
        }
    }

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

#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    if( objects && objects.count>0 && [[objects lastObject] isKindOfClass:[Trivia class]] ) {
        Trivia* tTrivia = [objects objectAtIndex:0];
        NSMutableArray* tAnswers = [NSMutableArray array];
        [tAnswers addObjectsFromArray:objects];
        for (int k=0,K=tAnswers.count;k<K;k++) {
            [tAnswers exchangeObjectAtIndex:k withObjectAtIndex:random() % (k + 1)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            TriviaViewController* tTriviaView = [[[TriviaViewController alloc] initWithNibName:@"TriviaView" bundle:[NSBundle mainBundle]] autorelease];
            tTriviaView.trivia = tTrivia;
            tTriviaView.possibleAnswers = tAnswers;
            
            tTriviaView.cancelBlock = ^{ 
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController dismissModalViewControllerAnimated:YES];
                });
            };
            tTriviaView.successBlock = ^(Trivia* aTrivia, BOOL aCorrectAnswer) {
                Attempt* tAttempt = [[[Attempt alloc] init] autorelease];
                tAttempt.triviaId = aTrivia.triviaId;
                tAttempt.correctAnswer = [NSNumber numberWithBool:aCorrectAnswer];
                [[RKObjectManager sharedManager] postObject:tAttempt delegate:self];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController dismissModalViewControllerAnimated:YES];
                });
            };
            UINavigationController* tNav = [[[UINavigationController alloc] initWithRootViewController:tTriviaView] autorelease];
            [self.navigationController presentModalViewController:tNav animated:YES];
        });
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    if( [object isKindOfClass:[Checkin class]] ) {
        Checkin* tCheckin = (Checkin*)object;
        NSMutableArray* tCheckins = [NSMutableArray arrayWithArray:assignment.checkins];
        [tCheckins addObject:tCheckin];
        assignment.checkins = [NSArray arrayWithArray:tCheckins];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckinSuccessful" object:nil];
        if( [tCheckin.trophyAwarded boolValue] ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TrophyAwarded" object:nil];
        }
    }else if( [object isKindOfClass:[Attempt class]] ) {
        Attempt* tAttempt = (Attempt*)object;
        if( [tAttempt.correctAnswer boolValue] ) {
            [self checkIn];
        }else{
            Alert(@"Incorrect Answer", @"Sorry, but that's not correct");
        }
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
//    Alert(@"Unable to checkin", [[error userInfo] objectForKey:@"NSLocalizedDescription"]);
    Alert(@"Unable to checkin", [error localizedDescription]);
}

@end
