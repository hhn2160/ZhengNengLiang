//
//  CameraViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-28.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)CloseCameraView:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *articleContent;

- (IBAction)AddArticle:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *cameraIamge;

@end
