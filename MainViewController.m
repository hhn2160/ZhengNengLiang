//
//  MainViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-21.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#import "MainViewCell.h"
#import "MainViewModel.h"
#import "ZNLLRestaurantAndGiftNetworkCenter.h"
#import "UIImageView+WebCache.h"
#import "MainDetailViewController.h"

@interface MainViewController ()
@property (nonatomic,strong) NSMutableArray *articleList;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _currentpage=1;
    self.articleList = [[NSMutableArray alloc]init];
    [self getArticleList];
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action: @selector(refreshTableView:)forControlEvents:UIControlEventValueChanged ];
    [self.MainTableView addSubview:rc];
    self.refreshControl=rc;
    //self.navigationController.navigationBar.alpha=1;
 
}

-(void) refreshTableView:(UIRefreshControl *)controller
{
    if(self.refreshControl.refreshing)
    {
        self.refreshControl.attributedTitle=[[NSAttributedString alloc] initWithString:@"加载中…"];
        [self getArticleList];
        [controller endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //self.navigationController.navigationBar.alpha=1;
    // Dispose of any resources that can be recreated.
}

- (void)getArticleList{
    NSDictionary *dict = @{
                           @"pid":([NSString stringWithFormat:@"%d", _currentpage]),
                           @"action":(@"getindexarticle")
                           };
    [NETWORK requestGetArticleByPageIdWithParmeter:dict completionHandler:^(id response, NSError *error) {
        //[self endLoading];
        
//        if (error) {
//            [self finishReloadingData];
//            [self showMessagePrompt:@"网络无法连接"];
//            return ;
//        }
        NSArray *resposeArray = response[@"TableInfo"];
//        if (resposeArray.count == 0) {
//            [self showMessagePrompt:@"暂时无订单"];
//        }
        [resposeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MainViewModel *item = [[MainViewModel alloc]init];
            item.articleTitle = obj[@"CArticle_Title"];
            item.articleImageUrl = obj[@"CArticle_Image"];
            item.imageHeight=[obj[@"CArticle_RealHeight"] integerValue];
            item.imageWidth=[obj[@"CArticle_RealWidth"] integerValue];
            item.articleCatchId=[obj[@"CArticle_Id"] integerValue];
            [self.articleList addObject:item];
        }];
//        NSLog([NSString stringWithFormat:@"%d", self.articleList.count]);
        [self.MainTableView reloadData];
        
//      [self finishReloadingData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.articleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"kaishi");
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"maincell"  forIndexPath:indexPath];
    MainViewModel *dict =self.articleList[indexPath.row];
    cell.mainTitleCell.text=dict.articleTitle;
    NSString *imagePath=dict.articleImageUrl;
    NSUInteger realwidth=dict.imageWidth;
    NSUInteger realheight=dict.imageHeight;
    NSUInteger showheight=340*realheight/realwidth;
    [cell.mainImageCell setFrame:CGRectMake(18,0,340,showheight)];
    [cell.mainTitleCell setFrame:CGRectMake(18,showheight-40,340,40)];
    [cell.mainImageCell sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //设置图片阴影
    [[cell.mainImageCell layer] setShadowOffset:CGSizeMake(1, 1)]; // 阴影的范围
    [[cell.mainImageCell layer] setShadowRadius:2];                // 阴影扩散的范围控制
    [[cell.mainImageCell layer] setShadowOpacity:1];               // 阴影透明度
    [[cell.mainImageCell layer] setShadowColor:[UIColor grayColor].CGColor]; // 阴影的颜色
    
    //兼容不同屏幕
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat screenwidth = size.width;
//    if(screenwidth==320.f)
//    {
//        [cell.mainTitleCell setFrame:CGRectMake(10,1,200,90)];
//        [cell.mainTitleCell setFont:[UIFont systemFontOfSize:18.0f]];
//        [cell.mainImageCell setFrame:CGRectMake(215,15,90,65)];
//        [cell setFrame:CGRectMake(0, 0, 300, 110)];
//    }
    //
    UIEdgeInsets edgeInset = self.MainTableView.separatorInset;
    self.MainTableView.separatorInset = UIEdgeInsetsMake(edgeInset.top, 0, edgeInset.bottom, 0);//修改分隔线长度
    self.MainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.MainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"maincell";
    MainViewCell *cell = (MainViewCell *)[[MainViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    MainViewModel *dict =self.articleList[indexPath.row];
    NSUInteger realwidth=dict.imageWidth;
    NSUInteger realheight=dict.imageHeight;
    NSUInteger showheight=340*realheight/realwidth;
    return cell.frame.size.height+showheight-33;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (([self.articleList count] == indexPath.row+1 && _loadingView.hidden == YES) ) {
        
        //NSLog(@"load data...");
        _currentpage++;
        _loadingView.hidden=NO;
        [self getArticleList];
    }
    else
    {
        _loadingView.hidden=YES;
    }
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMainDetail"]) {
        MainDetailViewController *newsDetail = (MainDetailViewController*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.MainTableView indexPathForCell:(UITableViewCell *)sender];
        MainViewModel *dict =self.articleList[indexPath.row];
        
        newsDetail.newsId= dict.articleCatchId;
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        
        
    }
}


@end
