//
//  HopListViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HopListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,RKObjectLoaderDelegate> {

    IBOutlet UISegmentedControl* modeSelect;
	IBOutlet UITableView* tableView;
	
	NSArray* hops;
    NSArray* allHops;
	
}

@property (retain) UISegmentedControl* modeSelect;
@property (retain) UITableView* tableView;
@property (retain) NSArray* hops;
@property (retain) NSArray* allHops;

@end
