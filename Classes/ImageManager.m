//
//  ImageManager.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/27/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "ImageManager.h"
#import "NSString+SHA1.h"


static int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ImageManager

+ (ImageManager*)sharedManager
{
    static ImageManager* sInstance;
    if( sInstance==nil ) {
        sInstance = [[ImageManager alloc] init];
    }
    return sInstance;
}

- (id)init
{
    downloadQueue = [[NSOperationQueue alloc] init];
    downloadQueue.maxConcurrentOperationCount = 3;
    
    activeDownloads = [[NSMutableSet set] retain];
    return self;
}

- (void)loadImageNamed:(NSString *)aName successBlock:(UIImageBlock)success failureBlock:(dispatch_block_t)failure
{
    if( aName==nil || [aName isEqual:[NSNull null]] ) {
        failure();
        return;
    }
    NSString* tLocalFile = [NSString stringWithFormat:@"%@/%@.png",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],[aName hexdigest]];
    // first, try to load file from local cache
    UIImage* tImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:tLocalFile]];
    if( tImage ) {
        DDLogVerbose(@"loaded local from %@", tLocalFile);
        success(tImage);
        return;
    }
    
    // now, try loading remotely
    if( ![activeDownloads containsObject:aName] ) {
        [activeDownloads addObject:aName];
        DDLogVerbose(@"loading %@",aName);
        [downloadQueue addOperationWithBlock:^{
            NSData* tRawImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:aName]];
            if( [tRawImage writeToFile:tLocalFile atomically:YES] ) {
                DDLogVerbose(@"stored as %@",tLocalFile);
            }else{
                DDLogVerbose(@"failed to store");
            }
            [activeDownloads removeObject:aName];
            UIImage* tImage = [UIImage imageWithData:tRawImage];
            if( tImage ) {
                success(tImage);
            }else{
                failure();
            }
        }];
    }
}

@end
