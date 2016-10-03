//
//  ImageShowViewController.h
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 02/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageShowViewController : UICollectionViewController {
    NSMutableArray* _imagesShow;
}

@property(strong, nonatomic) NSMutableArray* imagesShow;;

@end
