//
//  TVDBApi.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "TVDBApi.h"

@implementation TVDBApi

static NSString* API_KEY = @"C81A0DBC502DD6C8";

//+(NSString *)authenticateWithUsername:(NSString *)username andUserKey:(NSString *)userkey {
//    
//    NSString* url = @"https://api.thetvdb.com/login";
//    
//    NSDictionary* parameters = @{
//                           @"apikey": API_KEY,
//                           @"username": username,
//                           @"userkey": userkey
//                           };
//    
//    
//    __block NSString* token = nil;
//    
//    NSURLSessionDataTask* sessionDataTask = [TVDBApi dataTaskWithString:url andParameters:parameters completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
//        if (error == nil) {
//            if ([(NSHTTPURLResponse*)response statusCode] == 200) {
//                NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//                token = jsonData[@"token"];
//                NSLog(@"%@", token);
//            }
//        }
//    }];
//    
//    [sessionDataTask resume];
//    
//    return token;
//}

+(NSString *)authenticateWithUsername:(NSString *)username andUserKey:(NSString *)userkey {
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURL* url = [NSURL URLWithString:@"https://api.thetvdb.com/login"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary* data = @{
                           @"apikey": API_KEY,
                           @"username": username,
                           @"userkey": userkey
                           };
    
    NSError* error;
    NSData* postData = [NSJSONSerialization
                        dataWithJSONObject:data
                        options:NSJSONWritingPrettyPrinted
                        error:&error
                        ];
    [request setHTTPBody:postData];
    
    __block NSString* token = nil;
    
    NSURLSessionDataTask* sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (error == nil) {
            if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                token = jsonData[@"token"];
                NSLog(@"%@", token);
            }
        }
    }];
    
    [sessionDataTask resume];
    
    return token;
}

+ (NSURLSessionDataTask *)dataTaskWithString:(NSString *)string andParameters:(NSDictionary *)parameters completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler {
    NSURLSession* session = [NSURLSession sharedSession];
    NSURL* url = [NSURL URLWithString:string];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSError* error;
    NSData* postData = [NSJSONSerialization
                        dataWithJSONObject:parameters
                        options:NSJSONWritingPrettyPrinted
                        error:&error
                        ];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask* sessionDataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    
    return sessionDataTask;
}

+ (NSArray *)getLastUpdatedSeries {
    NSTimeInterval lastWeek = [[NSDate dateWithTimeIntervalSinceNow:(-60*60*24)] timeIntervalSince1970];
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    if (token) {
        
        NSURLSession* session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.thetvdb.com/updated/query?fromTime=%.0f", lastWeek]];
        
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [request setHTTPMethod:@"GET"];
        
//        NSDictionary* data = @{
//                               @"fromTime": API_KEY,
//                               };
//        
//        NSError* error;
//        NSData* postData = [NSJSONSerialization
//                            dataWithJSONObject:data
//                            options:NSJSONWritingPrettyPrinted
//                            error:&error
//                            ];
//        [request setHTTPBody:postData];
        
        __block NSArray* lastUpdated = nil;
        
        NSURLSessionDataTask* sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
            if (error == nil) {
                if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                    lastUpdated = jsonData[@"data"];
                    NSLog(@"%@", lastUpdated);
                }
            }
        }];
        
        [sessionDataTask resume];
        
        return lastUpdated;
    }
    
    return nil;
}

@end
