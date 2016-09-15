//
//  TVDBApi.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVDBApi : NSObject
+(NSURLSessionDataTask*)dataTaskWithString:(NSString*)string andParameters:(NSDictionary*)parameters completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;


+(void)authenticateWithUsername:(NSString*)username andUserKey:(NSString*)userkey completionHandler:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;;
+(void)getLastUpdatedSeriesWithCompletion:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;
@end
