//
//  NSData+Crypto.h
//  Demo
//
//  Created by Qi He on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData( Crypto )

- (NSData *) aesEncryptedDataWithKey:(NSData *) key;
- (NSString *) base64Encoding;

@end
