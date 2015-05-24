//
//  RegsiterViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-4.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RegsiterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userPhoneText;
@property (weak, nonatomic) IBOutlet UITextField *userCode;

- (IBAction)CheckPhone:(id)sender;

@end
