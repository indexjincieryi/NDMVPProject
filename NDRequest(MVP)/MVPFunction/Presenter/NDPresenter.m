//
//  NDPresenter.m
//  NDRequest(MVP)
//
//  Created by NDMAC on 15/12/31.
//  Copyright © 2015年 NDEducation. All rights reserved.
//

#import "NDPresenter.h"

#import "NDGPRequest.h"
#import "NDRequestManager.h"
#import "NDAppModel.h"
#import "NDAppModel.h"
@implementation NDPresenter


- (void)requestAppVersionsDataWithType:(NSString *)type
                             Bundle_id:(NSString *)bundle_id
                             Api_token:(NSString *)api_token
{
    NSDictionary * parameters = [ NSDictionary dictionaryWithObjectsAndKeys:type, @"type" ,bundle_id, @"bundle_id" ,api_token, @"api_token" , nil ];
    
    NDGPRequest *request = [NDGPRequest GPRequestWithOperationType:nil parameters:parameters];
    request.modelClass = [NDAppModel class];
    
    __weak __typeof(self) weakSelf = self;
    
    [[NDRequestManager sharedNDRequestManager] startRequest:request
                                                requestName:@"versionData"
                                              successAction:^(id object, NSString *requestName, NDGPRequest *gpRequest) {
                                                  NDAppModel *model = (NDAppModel *)object;
                                                  model.requestName = requestName;
                                                  
                                                  if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:appVersionsData:)]) {
                                                      [self.delegate presenter:weakSelf appVersionsData:model];
                                                  }
                                              } failAction:^(NSError *error, id object, NSString *requestName, NDGPRequest *gpRequest) {
                                                  
                                              }];
    
}

@end
