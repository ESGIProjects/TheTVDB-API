//
//  TVShow.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 16/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "TVShow.h"
#import "TVDBApi.h"

@implementation TVShow
@synthesize showId = _showId;
@synthesize name = _name;
@synthesize overview = _overview;
@synthesize genre = _genre;
@synthesize thumbnail = _thumbnail;
@synthesize favorite = _favorite;
@synthesize loaded = _loaded;

- (id)initWithId:(NSNumber*)identifier {
    if ((self = [super init])) {
        self.showId = identifier;
        self.loaded = NO;
    }
    return self;
}

- (void)updateWithCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion {
    [TVDBApi getTVShowWithId:self.showId completionHandler:completion];
}

@end
