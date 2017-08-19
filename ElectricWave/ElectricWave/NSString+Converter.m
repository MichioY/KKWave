//
//  NSString+Converter.m
//  ElectricWave
//
//  Created by SuperDry on 18/08/2017.
//  Copyright © 2017 Michio. All rights reserved.
//

#import "NSString+Converter.h"

@implementation NSString (Converter)
#pragma mark 十进制转二进制
+ (NSString *)convertBinarySystemFromDecimalSystem:(NSInteger)decimal
{
//    NSInteger num = [decimal intValue];
    NSInteger num = decimal;

    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true){
        
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%ld",remainder];
        
        if (divisor == 0){
            
            break;
        }
    }
    
    NSString * result = @"";
    
    for (NSInteger i = prepare.length - 1; i >= 0; i --){
        
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}

#pragma mark 二进制转十进制
+ (NSString *)convertDecimalSystemFromBinarySystem:(NSString *)binary
{
    NSInteger ll = 0 ;
    NSInteger  temp = 0 ;
    for (NSInteger i = 0; i < binary.length; i ++){
        
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%ld",ll];
    
    return result;
}

#pragma mark 二进制补位
+ (NSString *)dropAndFillWithLength:(NSInteger)length andString:(NSString *)string{
    
    NSString *subString = [string substringFromIndex:2];
    NSInteger sLen      = length - subString.length;
    
    NSMutableString *resultString = [NSMutableString string];

    for (NSInteger i = 0; i <= sLen; i++) {
        
        [resultString appendString:@"0"];
    }
    
    [resultString appendString:subString];
    return resultString;
}

#pragma mark 查找字符串中, 某个字符串个数
- (NSInteger)countOccurencesOfString:(NSString*)searchString {
    NSInteger strCount = [self length] - [[self stringByReplacingOccurrencesOfString:searchString withString:@""] length];
    return strCount / [searchString length];
}
@end
