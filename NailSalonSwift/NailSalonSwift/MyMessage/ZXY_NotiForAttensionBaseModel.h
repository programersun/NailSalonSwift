//
//  ZXY_NotiForAttensionBaseModel.h
//
//  Created by   on 15/5/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXY_NotiForAttensionContent;

@interface ZXY_NotiForAttensionBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ZXY_NotiForAttensionContent *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
