//
//  SR_OrderListBaseClass.h
//
//  Created by sun  on 15/5/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_OrderListBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double result;
@property (nonatomic, strong) NSArray *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
