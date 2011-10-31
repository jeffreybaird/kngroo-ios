//
//  LeadersViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudViewController.h"


@interface LeadersViewController : HudViewController <UITableViewDataSource,UITableViewDelegate,RKObjectLoaderDelegate> {
    
    IBOutlet UISegmentedControl* modeSelect;
    IBOutlet UITableView* tableView;
    NSArray* users;
    
}

@property (retain) UISegmentedControl* modeSelect;
@property (retain) UITableView* tableView;
@property (retain) NSArray* users;

@end
