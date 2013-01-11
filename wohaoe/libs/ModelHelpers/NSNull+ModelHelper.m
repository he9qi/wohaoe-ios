//
//  NSNull+ModelHelper.m
//  Demo
//
//  Created by Qi He on 12-2-20.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import "NSNull+ModelHelper.h"

@implementation NSNull (ModelHelper)

- (BOOL) isBlank
{
  return TRUE;
}

- (BOOL) isPresent
{
  return FALSE;
}

- (BOOL) isEqualToString:(NSString *)str
{
  return FALSE;
}

- (NSString *)stringByStandardizingWhitespace
{
  return nil;
}

- (int) length
{
  return 0;
}

@end
