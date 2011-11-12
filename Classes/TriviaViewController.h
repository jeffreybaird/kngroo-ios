//
//  TriviaViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trivia.h"
#import "Venue.h"


typedef void(^TriviaBlock)(Trivia*,BOOL);

@interface TriviaViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    
    IBOutlet UIImageView* venueImage;
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* addressLabel;
    IBOutlet UILabel* phoneLabel;
    IBOutlet UILabel* questionLabel;
    IBOutlet UITableView* tableView;
    
    Venue* venue;
    Trivia* trivia;
    NSArray* possibleAnswers;
    
    TriviaBlock successBlock;
    dispatch_block_t cancelBlock;
    
    int selectedIndex;
    
}

@property (retain) UIImageView* venueImage;
@property (retain) UILabel* titleLabel;
@property (retain) UILabel* addressLabel;
@property (retain) UILabel* phoneLabel;
@property (retain) UILabel* questionLabel;
@property (retain) UITableView* tableView;
@property (retain) Trivia* trivia;
@property (retain) Venue* venue;
@property (retain) NSArray* possibleAnswers;
@property (copy) TriviaBlock successBlock;
@property (copy) dispatch_block_t cancelBlock;

@end
