//
//  AssignmentCell.h
//  Kngroo
//
//  Created by Aubrey Goodman on 11/7/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentCell : UITableViewCell {
    
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* titleLabel;
    IBOutlet UIProgressView* progressView;
    IBOutlet UILabel* progressLabel;

}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* titleLabel;
@property (retain) UIProgressView* progressView;
@property (retain) UILabel* progressLabel;

@end
