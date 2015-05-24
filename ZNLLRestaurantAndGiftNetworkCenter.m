//
//  MILRestaurantAndGiftNetworkCenter.m
//  MIL
//
//  Created by xuqiaqng on 14-9-22.
//  Copyright (c) 2014年 MIL. All rights reserved.
//

#import "ZNLLRestaurantAndGiftNetworkCenter.h"
#import "AFNetworking.h"
@interface ZNLLRestaurantAndGiftNetworkCenter()


@property (nonatomic,readonly) NSString *baseURL;
@property (nonatomic,readonly) NSString *userId;
@property (nonatomic,strong) AFHTTPClient *client;
@end

@implementation ZNLLRestaurantAndGiftNetworkCenter

NSString *code = @"Code";
NSString *msg  = @"Message";

+(instancetype)shareCenter{
    static ZNLLRestaurantAndGiftNetworkCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[self alloc]init];
    });
    return center;
}

-(id)init{
    if (self = [super init]) {
        self.client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:self.baseURL]];
    }
    return self;
}

- (NSString *)baseURL{
    return @"http://znl.jingerge.com/control";
//    return @"http://192.168.1.100:8000/control";
}

- (NSString *)userId{
    NSLog(@"%@",@"uid");
    return @"uid";
    
}
- (void)requestGetArticleByPageIdWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler{
    [self.client getPath:@"app.aspx" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)requestGetUserArticleByPageIdWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler{
    [self.client getPath:@"app.aspx" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)requestGetUserPingLunByPageIdWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler{
    [self.client getPath:@"app.aspx" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)addUserPingLunWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler{
    [self.client postPath:@"user.aspx" parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response_data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)addUserLikeWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler{
    [self.client postPath:@"user.aspx" parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response_data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)addUserPhoneWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler{
    [self.client postPath:@"user.aspx" parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response_data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)userLoginWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler{
    [self.client postPath:@"user.aspx" parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response_data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}


#pragma mark - 请求商家列表,参数必须全

- (void)requestGetMerchantByCityIdWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler{
    [self.client getPath:@"Merchant/GetMerchantByCityId" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
    
}
- (void)requestGetMerchantByLocationWithParmeter:(NSDictionary*)paremeters completionHandler:(completionHandler)handler{
    [self.client getPath:@"Merchant/GetMerchantByZuoBiao" parameters:paremeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}



#pragma mark - 获取产品分类
- (void)requestGetMerchantCategoryWithMerchantId:(NSString *)merchantId completionHandler:(completionHandler)handler exceptionHandler:(excetionHandler)eHandler{
    [self.client getPath:@"Merchant/GetMerchantCategoryByMerId"
              parameters:@{@"merchantId":merchantId}
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     id parse_data = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
                     if ([parse_data[code] intValue] != 0) {
                         eHandler(parse_data[msg]);
                     }
                     handler(parse_data[AddTionalObject],nil);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     handler(nil,error);
                 }];
}
- (void)requestGetMerchantProductListWithMerchantId:(NSString *)merchantId compeltionHandler:(completionHandler)handler exceptionHandler:(excetionHandler)eHandler{
    [self.client getPath:@"Merchant/GetMerchantProductByMerId"
              parameters:@{@"merchantId":merchantId}
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     id parse_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                     if ([parse_data[code] intValue] != 0) {
                         eHandler(parse_data[msg]);
                     }
                     handler(parse_data[AddTionalObject],nil);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     handler(nil,error);
                 }];
    
}

#pragma mark - 获取礼品列表
- (void)getGiftWithParms:(NSDictionary *)params completionHandler:(completionHandler)handler{
    [self.client getPath:@"Gift" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([res[IsSuccess] boolValue])
        {
            handler(res[AddTionalObject][@"Giftitem"],nil);
        }
        else
        {
            handler(nil,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}

- (void)getGiftWithCategory:(NSDictionary *)params completionHandler:(completionHandler)handler{
    [self.client getPath:@"Gift" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([res[IsSuccess] boolValue])
        {
            handler(res[AddTionalObject][@"Items"],nil);
        }
        else
        {
            handler(nil,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}

#pragma mark - 获取礼品列表
- (void)getGiftItemWithGiftId:(NSString *)gId compeltionHandler:(completionHandler)handler{
    NSDictionary *dict = @{@"giftId":gId};
    
    [self.client getPath:@"Gift" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(result[AddTionalObject],nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}

- (void)getAreaListWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"ShippingAddress/GetCityList" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(obj,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
#pragma mark - get product detail
- (void)getProductDetailWithProductId:(NSString *)pid completionHandler:(completionHandler)handler{
    [self.client getPath:@"Product" parameters:@{
                                                 @"ProductId":pid
                                                 } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                     handler(result,nil);
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     handler(nil,error);
                                                 }];
}


#pragma mark - create order
- (void)createOrderWithParmas:(NSDictionary *)params completionHandler:(completionHandler)handler{
    [self.client postPath:@"Order" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id parse_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler (parse_data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        handler(nil,error);
    }];
}
#pragma mark - create Gift order
- (void)createGiftOrderWithParmas:(NSDictionary *)params completionHandler:(completionHandler)handler{
    [self.client postPath:@"GiftOrder" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id parse_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler (parse_data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)payGiftOrderWithOrderId:(NSString *)orderId
              completionHandler:(completionHandler)handler
{
    [self.client putPath:@"GiftOrder/PutGiftOrder" parameters:@{
                                                                @"orderId":orderId,
                                                                @"userId":self.userId
                                                                } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                    id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                                    handler(response,nil);
                                                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                    handler(nil,error);
                                                                }];
    
}
#pragma mark - searchOrder
- (void)getOrderListByOrderStatus:(NSUInteger)status completionHandler:(completionHandler)handler{
    NSDictionary *params = @{
                             @"userId":self.userId,
                             @"status":@(status)
                             };
    [self.client getPath:@"Order" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id resultData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(resultData,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}


- (void)loginWithUserName:(NSString*)uname userPassword:(NSString *)pass completionHandler:(completionHandler)handler exceptionHandler:(excetionHandler)eHandler{
    [self.client getPath:@"User/GetLogin" parameters:@{
                                                       @"userName":uname,
                                                       @"passWord":pass
                                                       } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                           id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                           if([result[@"IsSuccess"] integerValue] == 1){
                                                               handler(result,nil);
                                                           }else {
                                                               eHandler(result);
                                                           }
                                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                           handler(nil,error);
                                                       }];
}

- (void)regWithUserName:(NSString*)uname userPassword:(NSString*)password compltionHandler:(completionHandler)handler{
    
    
}

- (void)getUserDeleverayAddressWithCompletionHandler:(completionHandler)handler{
    
    [self.client getPath:@"ShippingAddress/GetShippingAddressListByUserId" parameters:@{
                                                                                        @"userId":self.userId
                                                                                        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                                                            handler(result,nil);
                                                                                            
                                                                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                            handler(nil,error);
                                                                                        }];
}

- (void)getProvinceIdWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"ShippingAddress/GetProviceList" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(result,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}
- (void)getCityListWithProvinceId:(NSString*)provinceId completionHandler:(completionHandler)handler{
    
    [self.client getPath:@"ShippingAddress/GetCityListByProviceId" parameters:@{@"proviceId":provinceId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(result,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
    
}

- (void)getAreaListByCityId:(NSString*)cityId completionHandler:(completionHandler)handler{
    [self.client getPath:@"ShippingAddress/GetAreaListByCityId" parameters:@{
                                                                             @"CityId":cityId
                                                                             } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                 id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                                                 handler(result,nil);
                                                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                 handler(nil,error);
                                                                             }];
}


- (void)saveNewAddressWithParams:(NSDictionary*)parameters completionHandler:(completionHandler)handler{
    [self.client postPath:@"ShippingAddress"
               parameters:parameters
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                      handler(response,nil);
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      handler(nil,error);
                  }];
}

- (void)setAddressDefaultWithShippingId:(NSString*)sid completionHandler:(completionHandler)handler{
    NSDictionary *d = @{
                        @"shippid":sid,
                        @"userId":self.userId
                        };
    [self.client putPath:@"ShippingAddress/PutDefault" parameters:d success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(result,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}

- (void)deleteAddressWithShippingId:(NSString*)sid completionHandler:(completionHandler)handler{
    [self.client deletePath:@"ShippingAddress" parameters:@{
                                                            @"id":sid
                                                            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                                handler(result,nil);
                                                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                handler(nil,error);
                                                            }];
    
}
- (void)modifyAddressWithShippinItem:(NSDictionary*)parameters completionHandler:(completionHandler)handler{
    [self.client putPath:@"ShippingAddress" parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     id result =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                     handler(result,nil);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     handler(nil,error);
                 }];
}

- (void)getGiftOrderListWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"GiftOrder/GetGiftOrderList" parameters:@{
                                                                    @"userId":self.userId,
                                                                    @"status":@(1)
                                                                    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                                        handler(result,nil);
                                                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                        handler(nil,error);
                                                                    }];
    
}

- (void)getGiftLineNumListWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"GiftOrder/GetGiftLineNumList" parameters:@{
                                                                    @"userId":self.userId,
                                                                    @"status":@(1)
                                                                    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                                        handler(result,nil);
                                                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                        handler(nil,error);
                                                                    }];
}

- (void)getUserInfoWithCompeletionHandler:(completionHandler)handler{
    [self.client getPath:@"User" parameters:@{
                                              @"UserId":self.userId
                                              } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                  handler(result,nil);
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  handler(nil,error);
                                              }];
    
}
- (void)getVeryCodeWithPhoneNo:(NSString*)phoneNo completionHandler:(completionHandler)handler{
    [self.client postPath:@"User/PostTelephoneCaptcha" parameters:@{
                                                                    @"TelePhone":phoneNo
                                                                    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                                        handler(result,nil);
                                                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                        handler(nil,error);
                                                                    }];
}


- (void)registerUserWithParameters:(NSDictionary*)userInfo completionHandler:(completionHandler)handler{
    [self.client postPath:@"User/PostCreateUser" parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(response_data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}

- (void)getIntegralWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"Order/GetIntegralRecordByUsreid"
              parameters:@{
                           @"userId":self.userId
                           }
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                     handler(response,nil);
                     
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     handler(nil,error);
                 }];
}



- (void)getRestaurantWithLocationSuccessWithCompletionHandler:(completionHandler)handler{
        NSDictionary *perameter = @{
                                @"Longitude":@"longtitude",
                                @"Latitude":@"latitude"
                                    };
    [self.client getPath:@"Merchant" parameters:perameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(result,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
    
}
- (void)getRestaurantWithLocationFailedWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"Merchant" parameters:@{
                                                  @"cityId":@"cityId"
                                                  } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                      handler(result,nil);
                                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      handler(nil,error);
                                                  }];
}
/*广告*/
- (void)getGiftAdvertWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"GiftAdvert" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(result,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
    
}

- (void)getVideoAdvertWithCompletionHandler:(completionHandler)handler{
    [self.client getPath:@"VideoAdvert/GetVideoAdVertList" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        handler(result,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
    
}

#pragma mark - To String
- (NSString *)paramsToString:(NSDictionary *)parmas{
    NSMutableString *paramsString = [NSMutableString stringWithString:@"?"];
    [parmas enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
        [paramsString appendFormat:@"%@&",parmas[key]];
    }];
    
    return [paramsString substringWithRange:NSMakeRange(0,
                                                        paramsString.length - 2)];
}




@end
