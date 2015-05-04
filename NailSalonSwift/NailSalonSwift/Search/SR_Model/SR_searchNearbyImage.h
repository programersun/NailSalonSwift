//
//  SR_searchNearbyImage.h
//
//  Created by sun  on 15/4/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_searchNearbyImage : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *cutHeight;
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *isFirst;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
