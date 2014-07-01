//
//  PhotosViewController.m
//  PhotoLibrary
//
//  Created by Eri Tange on 2014/04/17.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

#import "PhotosViewController.h"
#import "DetailViewController.h"

@interface PhotosViewController ()
@property(strong,nonatomic)NSArray *assets;

@end

@implementation PhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (!self.assets) {
        NSMutableArray *assets = [NSMutableArray array];
        self.assets = assets;
        [self.group enumerateAssetsUsingBlock:^(ALAsset *result,NSUInteger index,BOOL *stop){
            if (result) {
                [assets insertObject:result atIndex:0];
            }
            
        }];
        
        [self.collectionView reloadData];
    }
}

//-(void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    if (!self.assets) {
//        NSMutableArray *asssets = [NSMutableArray array];
//        self.assets = asssets;
//        [self.group enumerateAssetsUsingBlock:^ALAsset *result,NSInteger index,BOOL *stop){
//            if (result)
//                [asssets insertObject:result atIndex:0];
//            
//        }];
//        
//        [self.collectionView reloadData];
//    }
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.assets count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ALAsset *asset =self.assets[indexPath.item];
    
    //Main.storyBoard内で指定したタグをもとにImageViewを取得
    UIImageView *imageView = (id)[cell.contentView viewWithTag:10];
    imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailViewController *controller = segue.destinationViewController;
    NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems][0];
    controller.asset = self.assets[indexPath.item];
    
}


    
//    [super viewWillAppear:animated];
//    
//    if (!self.assets) {
//        
//        NSMutableArray *assets =[NSMutableArray array];
//        self.assets = assets;
//        [self.group enumerateAssetsUsingBlock:^(ALAsset *result, NSInteger index,BOOL *stop){
//            
//            if (result) {
//                
//                [assets insertObject:result atIndex:0];
//            }
//        
//        
//            [self.collectionView reloadData];
//}
//         }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
