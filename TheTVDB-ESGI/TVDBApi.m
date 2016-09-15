#import "TVDBApi.h"

@implementation TVDBApi

static NSString* API_KEY = @"C81A0DBC502DD6C8";

+(void)authenticateWithUsername:(NSString *)username andUserKey:(NSString *)userkey completionHandler:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion {
    
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
    
    
    NSURLSessionDataTask* sessionDataTask = [session dataTaskWithRequest:request completionHandler:completion];
    
    [sessionDataTask resume];
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

+ (void)getLastUpdatedSeriesWithCompletion:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion {
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
        
        
        NSURLSessionDataTask* task = [session dataTaskWithRequest:urlRequest completionHandler:completion];
        [task resume];
    }
    else {
        NSLog(@"Token is missing");
    }
}

@end
