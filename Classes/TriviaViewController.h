//
//  TriviaViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trivia.h"


typedef void(^TriviaBlock)(Trivia*,BOOL);

@interface TriviaViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    
    IBOutlet UILabel* questionLabel;
    IBOutlet UITableView* tableView;
    Trivia* trivia;
    NSArray* possibleAnswers;
    TriviaBlock successBlock;
    dispatch_block_t cancelBlock;
    
    int selectedIndex;
    
}

@property (retain) UILabel* questionLabel;
@property (retain) UITableView* tableView;
@property (retain) Trivia* trivia;
@property (retain) NSArray* possibleAnswers;
@property (copy) TriviaBlock successBlock;
@property (copy) dispatch_block_t cancelBlock;

@end
