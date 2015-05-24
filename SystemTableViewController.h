//
//  SystemTableViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-26.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemTableViewController : UITableViewController
- (IBAction)loginOut:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *systemTable;

@end
