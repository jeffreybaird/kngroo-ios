//
//  ImageManager.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/27/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^UIImageBlock)(UIImage*);


@interface ImageManager : NSObject {
    
    NSOperationQueue* downloadQueue;
    NSMutableSet* activeDownloads;
    
}

+(ImageManager*)sharedManager;
-(void)loadImageNamed:(NSString*)aName successBlock:(UIImageBlock)success failureBlock:(dispatch_block_t)failure;

@end
