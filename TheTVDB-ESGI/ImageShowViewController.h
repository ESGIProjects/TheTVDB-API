//
//  ImageShowViewController.h
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 02/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShow.h"

@interface ImageShowViewController : UICollectionViewController {
    TVShow* _tvShow;
    NSMutableArray* _imagesShow;
}
@property(strong, nonatomic) TVShow* tvShow;
@property(strong, nonatomic) NSMutableArray* imagesShow;;

@end
