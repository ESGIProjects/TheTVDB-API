//
//  TVDBApi.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVDBApi : NSObject
+(NSURLSessionDataTask*)dataTaskWithString:(NSString*)string andParameters:(NSDictionary*)parameters completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
+(void)authenticateWithUsername:(NSString*)username andUserKey:(NSString*)userkey completionHandler:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;
+(void)getLastUpdatedSeriesWithCompletion:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;
+ (void)getFavoritesWithCompletion:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;
+(void)getTVShowWithId:(NSNumber*)identifier completionHandler:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;
+(UIImage*)loadImageWithURL:(NSURL*)url;
+(void)getImageQueryWithId:(NSNumber*)identifier completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completion;
+(void)getImageWithId:(NSNumber*)identifier andQuery:(NSString*)query completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completion;
+(void)getEpisodesWithTVShowId:(NSNumber*)identifier completionHandler:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;
@end
