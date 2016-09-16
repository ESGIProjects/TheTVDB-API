//
//  TVShow.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 16/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVShow : NSObject {
    NSInteger _showId;
    NSString* _name;
    NSString* _overview;
}

@property(assign, nonatomic) NSInteger showId;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* overview;

-(id)initWithId:(NSInteger)id andName:(NSString*)name;

@end
