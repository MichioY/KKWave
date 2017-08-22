//
//  NSString+Converter.h
//  ElectricWave
//
//  Created by SuperDry on 18/08/2017.
//  Copyright © 2017 Michio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Converter)
/* 十进制转二进制**/
+ (NSString *)convertBinarySystemFromDecimalSystem:(NSInteger)decimal;

/* 二进制转十进制**/
+ (NSString *)convertDecimalSystemFromBinarySystem:(NSString *)binary;

/* 二进制补位**/
+ (NSString *)dropAndFillWithLength:(NSInteger)length andString:(NSString *)string;

/* 查找字符串中, 某个字符串个数**/
- (NSInteger)countOccurencesOfString:(NSString*)searchString;
@end
