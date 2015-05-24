//
//  MILRestaurantAndGiftNetworkCenter.h
//  MIL
//
//  Created by xuqiaqng on 14-9-22.
//  Copyright (c) 2014年 MIL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SuccessCode @"Code"
#define AddTionalObject @"AdditionalObject"
#define IsSuccess @"IsSuccess"

#define NETWORK [ZNLLRestaurantAndGiftNetworkCenter shareCenter]
typedef void (^completionHandler)(id response, NSError *error);
typedef void (^excetionHandler)(id response);

@interface ZNLLRestaurantAndGiftNetworkCenter: NSObject

extern NSString const *code;
extern NSString const *msg;

+(instancetype)shareCenter;


- (void)requestGetArticleByPageIdWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler;

- (void)requestGetUserArticleByPageIdWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler;
- (void)addUserArticleWithParmas:(NSDictionary*)parameters imageData:(NSData*)data  completionHandler:(completionHandler)handler;

- (void)addUserPhoneWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler;
- (void)requestGetUserPingLunByPageIdWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler;
- (void)addUserPingLunWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler;
- (void)addUserLikeWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler;
- (void)userLoginWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler;
//--------------

- (void)requestGetMerchantCategoryWithMerchantId:(NSString *)merchantId completionHandler:(completionHandler)handler exceptionHandler:(excetionHandler)eHandler;
- (void)requestGetMerchantProductListWithMerchantId:(NSString *)merchantId compeltionHandler:(completionHandler)handler exceptionHandler:(excetionHandler)eHandler;
- (void)getGiftWithParms:(NSDictionary *)params completionHandler:(completionHandler)handler;

- (void)getGiftWithCategory:(NSDictionary *)params completionHandler:(completionHandler)handler;

- (void)getGiftItemWithGiftId:(NSString *)gId compeltionHandler:(completionHandler)handler;

- (void)getAreaListWithCompletionHandler:(completionHandler)handler;
- (void)getProductDetailWithProductId:(NSString *)pid completionHandler:(completionHandler)handler;
- (void)createOrderWithParmas:(NSDictionary *)params completionHandler:(completionHandler)handler;
- (void)createGiftOrderWithParmas:(NSDictionary *)params completionHandler:(completionHandler)handler;
- (void)payGiftOrderWithOrderId:(NSString *)orderId
              completionHandler:(completionHandler)handler;

- (void)getOrderListByOrderStatus:(NSUInteger)status completionHandler:(completionHandler)handler;

- (void)loginWithUserName:(NSString*)uname userPassword:(NSString *)pass completionHandler:(completionHandler)handler exceptionHandler:(excetionHandler)eHandler;
- (void)getUserDeleverayAddressWithCompletionHandler:(completionHandler)handler;

/*获取到省市区*/

- (void)getProvinceIdWithCompletionHandler:(completionHandler)handler;
- (void)getCityListWithProvinceId:(NSString*)provinceId completionHandler:(completionHandler)handler;
- (void)getAreaListByCityId:(NSString*)cityId completionHandler:(completionHandler)handler;
/*收货地址处理*/
- (void)saveNewAddressWithParams:(NSDictionary*)parameters completionHandler:(completionHandler)handler;
- (void)setAddressDefaultWithShippingId:(NSString*)sid completionHandler:(completionHandler)handler;
- (void)deleteAddressWithShippingId:(NSString*)sid completionHandler:(completionHandler)handler;
- (void)modifyAddressWithShippinItem:(NSDictionary*)parameters completionHandler:(completionHandler)handler;
- (void)getGiftOrderListWithCompletionHandler:(completionHandler)handler;
- (void)getGiftLineNumListWithCompletionHandler:(completionHandler)handler;
/*用户信息*/
- (void)getUserInfoWithCompeletionHandler:(completionHandler)handler;

- (void)getVeryCodeWithPhoneNo:(NSString*)phoneNo completionHandler:(completionHandler)handler;

- (void)registerUserWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler;

- (void)getIntegralWithCompletionHandler:(completionHandler)handler;

- (void)getRestaurantWithLocationSuccessWithCompletionHandler:(completionHandler)handler;
- (void)getRestaurantWithLocationFailedWithCompletionHandler:(completionHandler)handler;
/*广告*/
- (void)getGiftAdvertWithCompletionHandler:(completionHandler)handler;
- (void)getVideoAdvertWithCompletionHandler:(completionHandler)handler;

@end
