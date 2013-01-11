//
//  NSString+Crypto.h
//  Demo
//
//  Created by Qi He on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString( Crypto )

- (NSData *) sha256;

- (NSString*)MD5EncodedString;
- (NSData*)HMACSHA1EncodedDataWithKey:(NSString*)key;
- (NSString*)base64EncodedString;
- (NSString*)URLEncodedString;
- (NSString*)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding;

@end

