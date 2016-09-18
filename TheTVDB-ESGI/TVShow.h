//
//  TVShow.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 16/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVShow : NSObject {
    NSNumber* _showId;
    NSString* _name;
    NSString* _overview;
    NSArray* _genre;
}

@property(strong, nonatomic) NSNumber* showId;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* overview;
@property(strong, nonatomic) NSArray* genre;

-(id)initWithId:(NSNumber*)identifier;
-(void)updateWithCompletion:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completion;

@end
