# -*- coding: utf-8 -*-
"""
Created on Tue Jan 19 15:26:45 2016

@author: zhengbowang
"""
# import pyaudio
import struct
import datetime
import math

def dropandfill(l,s):

    # 用 0 补位
    sLen = l - len(s[2:])

    result = '0' * sLen + s[2:]

    print ('dropandfill - l:%s, s:%s' % (l, s))
    print ('dropandfill - len(s[2:]):%s, s[2:]:%s' % (len(s[2:]) , s[2:]))
    print ('dropandfill - (l - len(s[2:])):%s, result:%s' % ((l - len(s[2:])) , result))


    return result

def time2code(date_time, dt = datetime.timedelta(0)):

#将时间转换成 BPC 编码。

    print ('1.  dt:%s'% dt)

    # 日期
    date_time -= dt
    print ('2.  date_time:%s' % date_time)

    # 日期数组
    date = [date_time.day, date_time.month, date_time.year]
    print ('3.  date:%s'% date)

    # 时间数组
    timet = [date_time.hour,date_time.minute,date_time.weekday()+1]
    print ('4.  timet:%s'% timet)

    # 年份
    date[2] = date[2]%100#year
    print ('5.  date[2]:%s'% date[2])

    # 上午 下午
    timet[0] = timet[0]%12#am.pm
    print ('6.  timet[0]:%s'% timet[0])

    # 1. 帧周期 20秒 date_time.second/20 ?
    # 2. 2?
    p1 = dropandfill(2,bin(date_time.second/20))#seconds
    print ('7.  p1:%s, bin(date_time.second/20): %s' % (p1, bin(date_time.second/20)))

    p2 = '00'#reserved

    sec1Temp = ''.join(map(dropandfill,[4,6,4],map(bin,timet)))
    print ('8.0 sec1Temp:%s' % sec1Temp)
    sec1 = (p1+p2) + sec1Temp
    print ('8.  sec1:%s'% sec1)

    p31 = str(int(date_time.hour>=12))
    print ('9.  p31:%s'% p31)

    p32 = str((sec1.count('1'))%2)
    print ('10. p32:%s'% p32)

    p3 = p31 + p32
    print ('11. p3:%s'% p3)

    sec2 = ''.join(map(dropandfill,[6,4,6],map(bin,date)))
    print ('12. sec2:%s'% sec2)

    p41 = str(int(date_time.year%1000>100))
    print ('13. p41:%s'% p41)

    p42 = str(((sec2.count('1'))%2))
    print ('14. p42:%s'% p42)

    p4 = p41 + p42
    print ('15. p4:%s'% p4)

    code2 = sec1 + p3 +sec2 + p4
    print ('16. code2:%s'% code2)

    bin2four = {'00':'1','01':'2','10':'3','11':'4'}#to base4
    print ('17. bin2four:%s'% bin2four)

    return '0'+''.join([bin2four[code2[2*i:2*i+2]] for i in range(len(code2)/2)])


dt = datetime.timedelta(hours = 1)#fake time shift
# 频率为68.5千赫
samp_rate = 68500
freq = 6850 * 2 #in Hertz
# 帧周期长度为20s
ttime =20 #in Sec

SAMPLE_LEN = samp_rate * ttime # 20 seconds of cosine
value = ampl = 32725
div = samp_rate/freq/2
data = 32725

date_time = datetime.datetime.now()+dt
print date_time
sec = (date_time.second+1)%20
code_str = time2code(date_time)
print(dt, samp_rate, freq, SAMPLE_LEN, div, sec, code_str)

# 打开声音输出流
# p = pyaudio.PyAudio()
# stream = p.open(format = 8,
#                 channels = 1,
#                 rate = samp_rate,
#                 output = True)

# while True:
#     date_time = datetime.datetime.now()+dt
#     print date_time
#     sec = (date_time.second+1)%20
#     code_str = time2code(date_time)
#     start = sec * samp_rate
#     for i in xrange((start), SAMPLE_LEN):
#         #if i % div == 0:value = -value#carrier generate
#         value = ampl * int(math.cos(math.pi / float(div) * float(i)))
#         pulse = (i - sec * samp_rate)/(samp_rate / 10)
#         packed_value = struct.pack('h', int(pulse >= int(code_str[sec]))*value)
#         stream.write(packed_value)
#         if i % samp_rate == 0 and i != start:
#             sec = sec + 1


# from datetime import timedelta
# from datetime import  datetime
# now = datetime.now()