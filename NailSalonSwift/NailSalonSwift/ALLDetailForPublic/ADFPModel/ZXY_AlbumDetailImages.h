//
//  ZXY_AlbumDetailImages.h
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_AlbumDetailImages : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *isFirst;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *cutHeight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
