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
    
    NSURLSessionDataTask* sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        NSLog(@"Data: %@", data.description);
        NSLog(@"Response: %@", response.description);
        
        
    }];
    
    [sessionDataTask resume];
    
    return @"";
}

@end
