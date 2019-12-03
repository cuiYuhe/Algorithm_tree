//
//  YHBook.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/24.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBook.h"

@implementation YHBook

- (NSComparisonResult)compare:(YHBook *)element{
    if (self.page > element.page) {
        return NSOrderedDescending;
    }else if (self.page < element.page) {
        return NSOrderedAscending;
    }
    return NSOrderedSame;
}

+ (YHBook *)yh_bookWithPage:(int)page type:(NSString *)type{
    YHBook *book = [self new];
    book.page = page;
    book.type = type;
    return book;
}

- (NSString *)description{
//    NSString *result = [NSString stringWithFormat:@"book: type: %@, page: %d", self.type, self.page];
    NSString *result = [NSString stringWithFormat:@"book page: %d", self.page];
    return result;
}

//- (void)dealloc{
//    NSLog(@"book dealloc");
//}

@end
