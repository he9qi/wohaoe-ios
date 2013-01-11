//
//  NSNull+ModelHelper.h
//  Demo
//
//  Created by Qi He on 12-2-20.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (ModelHelper)

- (BOOL) isBlank;
- (BOOL) isPresent;
- (BOOL) isEqualToString:(NSString *)str;

- (NSString *)stringByStandardizingWhitespace;
- (int) length;

@end
