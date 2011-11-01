//
//  NSString+MD5.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (MD5)

- (NSString*)md5
{
	NSData* tStringData = [self dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char tHashBytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5([tStringData bytes], [self length], tHashBytes);
	
    NSData* tRawHash = [NSData dataWithBytes:tHashBytes length:CC_MD5_DIGEST_LENGTH];
	NSString* tHex = [tRawHash description];
	tHex = [tHex stringByReplacingOccurrencesOfString:@"<" withString:@""];
	tHex = [tHex stringByReplacingOccurrencesOfString:@">" withString:@""];
	tHex = [tHex stringByReplacingOccurrencesOfString:@" " withString:@""];
	return tHex;
}

@end
