//
//  VenueViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/23/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hop.h"
#import "Venue.h"
#import "Assignment.h"


@interface VenueViewController : UIViewController <RKObjectLoaderDelegate> {
    
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* descriptionLabel;
    IBOutlet UIButton* checkInButton;
    IBOutlet UILabel* checkedInLabel;
    
    Hop* hop;
    Venue* venue;
    Assignment* assignment;
    
}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* titleLabel;
@property (retain) UILabel* descriptionLabel;
@property (retain) UIButton* checkInButton;
@property (retain) UILabel* checkedInLabel;
 
@property (retain) Hop* hop;
@property (retain) Venue* venue;
@property (retain) Assignment* assignment;

-(IBAction)checkIn:(id)sender;

@end
