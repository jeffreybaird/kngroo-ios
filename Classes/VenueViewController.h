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


@interface VenueViewController : UIViewController {
    
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* descriptionLabel;
    IBOutlet UIButton* checkInButton;
    
    Hop* hop;
    Venue* venue;
    
}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* titleLabel;
@property (retain) UILabel* descriptionLabel;
@property (retain) UIButton* checkInButton;
@property (retain) Hop* hop;
@property (retain) Venue* venue;

-(IBAction)checkIn:(id)sender;

@end
