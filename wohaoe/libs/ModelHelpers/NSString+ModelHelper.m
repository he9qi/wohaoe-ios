//
//  NSString+ModelHelper.m
//  Demo
//
//  Created by Qi He on 12-2-20.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import "NSString+ModelHelper.h"

@implementation NSString (ModelHelper)

- (BOOL) isBlank
{
  return [self isEqualToString:@"null"] || [self isEqualToString:@""];
}

- (BOOL) isPresent
{
  return ![self isBlank];
}

@end
