//
//  YHBstNode.h
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/20.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCompareProtocol.h"



@interface YHBstNode : NSObject

/// 元素
@property (nonatomic, strong) id<YHCompareProtocol> element;
/// 父节点
@property (nonatomic, weak) YHBstNode *parent;
/// 左节点
@property (nonatomic, strong) YHBstNode *left;
/// 右节点
@property (nonatomic, strong) YHBstNode *right;
/// 是否叶子节点
@property (nonatomic, assign, readonly) BOOL isLeaf;
/// 是否度为2
@property (nonatomic, assign, readonly) BOOL isTwoDegrees;

+ (__kindof YHBstNode *)yh_nodeWithElement:(id)ele parent:(YHBstNode *)parent;
///兄弟节点
- (__kindof YHBstNode *)siblingNode;
- (BOOL)isLeftChild;
- (BOOL)isRightChild;


@end

