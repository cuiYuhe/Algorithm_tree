//
//  YHBook.h
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/24.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCompareProtocol.h"

@interface YHBook : NSObject<YHCompareProtocol>

/// 页数
@property (nonatomic, assign) int page;
@property (nonatomic, copy) NSString *type;

+ (__kindof YHBook *)yh_bookWithPage:(int)page type:(NSString *)type;

@end

