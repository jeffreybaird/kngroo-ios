//
//  HopListViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "V8HorizontalPickerView.h"
#import "HudViewController.h"
#import "Hop.h"


typedef BOOL(^HopSelectorBlock)(Hop*);

@interface HopListViewController : HudViewController <RKObjectLoaderDelegate,V8HorizontalPickerViewDataSource,V8HorizontalPickerViewDelegate> {
    
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

-(void)showHops:(HopSelectorBlock)selectBlock;
-(void)showCategoryPicker;
-(void)hideCategoryPicker;

@end
