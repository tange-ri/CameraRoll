//
//  GroupsViewController.m
//  PhotoLibrary
//
//  Created by Eri Tange on 2014/04/17.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

#import "GroupsViewController.h"
#import "PhotosViewController.h"

@interface GroupsViewController ()
@property(strong,nonatomic)ALAssetsLibrary *library;
@property(strong,nonatomic)NSArray *groups;

@end

@implementation GroupsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //ALAssetsGroupを読み込む
    ALAssetsLibrary *liberary = [[ALAssetsLibrary alloc] init];
    self.library = liberary;
    
    //NSMutableArrayの要素と追加した行数が合っていない
    //NSMutableArray=可変のNSArray
    NSMutableArray *groups = [NSMutableArray array];
    self.groups = groups;
    
    //非同期に実行されるので、グループが追加する度にテーブルを更新するようにする
    //ALAssetsLibraryからアルバムを取得するのは、「enumerateGroupsWithTypes: usingBlock: failureBlock:」
    
    [liberary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group,BOOL *stop){
        
        if (group) {
            
            //NSIndexPath = 行とセクションを入れる。別々に取得できる。
            //行はグループの数、セクションは0番目(=1個ある)
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[groups count] inSection:0];
            
            //写真を取得するフィルタを設定
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [groups addObject:group];
            
            //indexPathで指定したセルを描画
            //tableView:numberOfRowsInSection:numberOfSectionsInTableViewとの整合性
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }failureBlock:^(NSError *error){
        
    }];
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    //セクションの数
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [self.groups count];
}

//グループの見出し画像、グループ名、アセット数をそれぞれセルの各パーツへ代入
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    
    ALAssetsGroup *group = self.groups[indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:[group posterImage]];
    cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",[group numberOfAssets]];
    
    return cell;
}

//Segueで移動するときにグループをわたす処理
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //行き先はPhotosViewController
    PhotosViewController *controller = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    controller.group = self.groups[indexPath.row];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
