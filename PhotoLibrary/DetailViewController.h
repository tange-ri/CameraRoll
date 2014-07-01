//
//  DetailViewController.h
//  PhotoLibrary
//
//  Created by Eri Tange on 2014/04/25.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    
    IBOutlet UIScrollView *imageView;
}

-(IBAction)performShareButtonAction;
-(IBAction)scrollViewTapped;

@property(strong,nonatomic) ALAsset *asset;
@end
