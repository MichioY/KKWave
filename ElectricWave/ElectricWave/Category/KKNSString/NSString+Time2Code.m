//
//  NSString+Time2Code.m
//  ElectricWave
//
//  Created by SuperDry on 21/08/2017.
//  Copyright © 2017 Michio. All rights reserved.
//

#import "NSString+Time2Code.h"
#import "NSDate+YYAdd.h"
#import "NSString+Converter.h"

@implementation NSString (Time2Code)
+ (NSString *)secStringWithArray:(NSArray *)tempSecArray timeArray:(NSArray *)timeArray {
    
    NSMutableArray *timeBinaryMArray1 = [NSMutableArray array];
    NSMutableArray *timeBinaryMArray2 = [NSMutableArray array];
    
    [tempSecArray enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [timeBinaryMArray1 addObject:[NSString convertBinarySystemFromDecimalSystem:obj.integerValue]];
    }];
    
    [timeArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [timeBinaryMArray2 addObject:[NSString convertBinarySystemFromDecimalSystem:obj.integerValue]];
    }];
    
    
    //    sec1 = (p1+p2)+''.join(map(dropandfill,[4,6,4],map(bin,timet)))
    
    NSString *sec = [NSString stringWithFormat:@"%@%@",
                     [timeBinaryMArray1 componentsJoinedByString:@""],
                     [timeBinaryMArray2 componentsJoinedByString:@""]];
    
    return sec;
}

+ (NSString *)timeToCodeWithTime:(NSDate *)time{
    
    NSDate *date    = time;
    
    NSString *day   = [NSString stringWithFormat:@"%ld", (long)date.day];
    NSString *month = [NSString stringWithFormat:@"%ld", (long)date.month];
    NSString *year  = [NSString stringWithFormat:@"%ld", date.year % 100];
    
    NSString *hour      = [NSString stringWithFormat:@"%ld", date.hour % 12];
    NSString *minute    = [NSString stringWithFormat:@"%ld", (long)date.minute];
    NSString *weekday   = [NSString stringWithFormat:@"%ld", date.weekday + 1];
    
    NSArray *dateArray = @[day, month, year];
    NSArray *timeArray = @[hour, minute, weekday];
    
    //    p1 = dropandfill(2,bin(date_time.second/20))#seconds
    NSString *p1 = [NSString convertBinarySystemFromDecimalSystem:date.second / 20];
    NSString *p2 = @"00";
    
    //    sec1 = (p1+p2)+''.join(map(dropandfill,[4,6,4],map(bin,timet)))
    NSString *p1AppendP2 = [p1 stringByAppendingString:p2];
    NSString *sec1 = [NSString stringWithFormat:@"%@%@",p1AppendP2, [NSString secStringWithArray:@[@"4", @"6", @"4"] timeArray:timeArray]];
    
    //    p31 = str(int(date_time.hour>=12))
    NSString *p31 = [NSString stringWithFormat:@"%d", date.hour >= 12];
    
    //    p32 = str((sec1.count('1'))%2)
    NSString *p32 = [NSString stringWithFormat:@"%ld", ([sec1 countOccurencesOfString:@"1"] % 2)];
    
    //    p3 = p31 + p32
    NSString *p3 = [NSString stringWithFormat:@"%@%@", p31, p32];
    
    //    sec2 = ''.join(map(dropandfill,[6,4,6],map(bin,date)))
    NSString *sec2 = [NSString secStringWithArray:@[@"6",@"4",@"6"] timeArray:dateArray];
    
    //    p41 = str(int(date_time.year%1000>100))
    NSString *p41 = [NSString stringWithFormat:@"%d", ((date.year % 1000) > 100)];
    
    //    p42 = str(((sec2.count('1'))%2))
    NSString *p42 = [NSString stringWithFormat:@"%ld", ([sec2 countOccurencesOfString:@"1"] % 2)];
    
    //    p4 = p41 + p42
    NSString *p4 = [NSString stringWithFormat:@"%@%@", p41, p42];
    
    //    code2 = sec1 + p3 +sec2 + p4
    NSString *code2 = [NSString stringWithFormat:@"%@%@%@%@", sec1, p3, sec2, p4];
    
    //    NSString *code2 = @"00000011110111000110010101100001000100";
    //    bin2four = {'00':'1','01':'2','10':'3','11':'4'}#to base4
    NSDictionary *bin2Four = @{  @"00":@"1",
                                 @"01":@"2",
                                 @"10":@"3",
                                 @"11":@"4"};
    
    NSInteger code2Length = code2.length/2;
    
    NSMutableArray *code2MArray = [NSMutableArray arrayWithCapacity:code2Length];
    for (NSInteger i = 0; i <= code2Length - 1; i++) {
        
        NSString *tempKey = [code2 substringWithRange:NSMakeRange(2 * i, 2)];
        [code2MArray addObject:[bin2Four objectForKey:tempKey]];
    }
    
    NSString *resultString = [NSString stringWithFormat:@"0%@", [code2MArray componentsJoinedByString:@""]];
    
    
    return resultString;
}
@end
