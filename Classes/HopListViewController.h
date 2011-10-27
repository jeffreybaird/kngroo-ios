//
//  HopListViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "V8HorizontalPickerView.h"


@interface HopListViewController : UIViewController <RKObjectLoaderDelegate,V8HorizontalPickerViewDataSource,V8HorizontalPickerViewDelegate> {
    
    IBOutlet UISegmentedControl* modeSelect;
	IBOutlet UITableView* tableView;
    IBOutlet V8HorizontalPickerView* categoryPicker;
	
    NSArray* hops;
    NSArray* allHops;
    NSArray* categories;
    BOOL categoryPickerVisible;
    int selectedCategoryId;
    
}

@property (retain) UISegmentedControl* modeSelect;
@property (retain) UITableView* tableView;
@property (retain) V8HorizontalPickerView* categoryPicker;
@property (retain) NSArray* hops;
@property (retain) NSArray* allHops;
@property (retain) NSArray* categories;

@end
