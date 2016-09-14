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
        [request addValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
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
                    NSLog(@"%@", jsonData);
                }
            }
        }];
        
        [sessionDataTask resume];
        
        return lastUpdated;
    }
    
    return nil;
}

/*NSURLSession* session = [NSURLSession sharedSession];
NSURL* url = [NSURL URLWithString:@"http://api.thetvdb.com/updated/query?fromTime=1473690547"];

NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

NSString* tokenString = @"Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE0NzM5Njk3MTYsImlkIjoiTXlTZXJpZXNQcm9qZWN0Iiwib3JpZ19pYXQiOjE0NzM4ODMzMTYsInVzZXJpZCI6NDU4MTg1LCJ1c2VybmFtZSI6IlNpaWx2ZXI3NzcifQ.sfb_kcww0EmfLdj_lDvdM3VrUb_pGNm63G09CIjHyBWPr5uxZvY7W9V5A3WK5ZcnK7uuy1tBszftxcO4AjKdLl8O41ryrYNVrNzWjhKhbFw6PBG76PvGlD6K03yZVMWO7DrCPskBufrPEMIct50mVRCcNWkJef-2gdwfEosxm_DOsgmcJPry8mkhtaeFOCDGO5D9Ez95CpOrmu91uDIPFEMR2cTxxblJmUwxLCWDkYDLRsSmbA-PUDGgg11QvlAPQ3wlIjGgoOTiYLs2o68mHiiXQHBbvF-PFdMN-GEvP5ux-cz4zRqDL0LAv2cAPlEwFI4ZD1McQvPtQQqKO8W6QA";

[urlRequest setValue:tokenString forHTTPHeaderField:@"Authorization"];
[urlRequest setHTTPMethod:@"GET"];

NSURLSessionDataTask* task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
    if (data) {
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", json);
    }
    NSLog(@"%@", response.description);
    NSLog(@"%@", error.localizedDescription);
}];

[task resume];*/

+ (NSArray*)test {
    // Infos nécessaires
    NSTimeInterval lastWeek = [[NSDate dateWithTimeIntervalSinceNow:(-60*60*24)] timeIntervalSince1970];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.thetvdb.com/updated/query?fromTime=%.0f", lastWeek]];
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    // Vérification du token avant de continuer
    if (token) {
        NSURLSession* session = [NSURLSession sharedSession];
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"GET"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [urlRequest setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        
        __block NSArray* lastUpdated = nil;
        
        NSURLSessionDataTask* task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
            if (data) {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (json) {
                    lastUpdated = json[@"data"];
                }
                else {
                    NSLog(@"%@", error.localizedDescription);
                }
            }
            else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
        
        [task resume];
    
        return lastUpdated;
    }
    
    return nil;
}

@end
