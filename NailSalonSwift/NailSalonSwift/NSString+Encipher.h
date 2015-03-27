//
//  NSString+Encipher.h
//  KickYourAss
//
//  Created by 宇周 on 15/1/21.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (Encipher)
- (NSString *)md2;

- (NSString *)md4;

- (NSString *)md5;

- (NSString *)sha1;

- (NSString *)sha224;

- (NSString *)sha256;

- (NSString *)sha384;

- (NSString *)sha512;
@end
