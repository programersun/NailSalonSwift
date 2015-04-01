//
//  ZXYOfferData.h
//
//  Created by   on 15/3/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXYOfferData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *recommendAlbum;
@property (nonatomic, strong) NSArray *lastAlbum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
