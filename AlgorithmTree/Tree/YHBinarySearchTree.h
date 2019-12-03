//
//  YHBinarySearchTree.h
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/20.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBinaryTree.h"
#import "MJBinaryTreeInfo.h"

/*
 添加、删除、是否包含都要比较大小,是搜索二叉树才有的方法
 */

@interface YHBinarySearchTree : YHBinaryTree<MJBinaryTreeInfo>

- (void)add:(id<YHCompareProtocol>)element;
- (BOOL)contains:(id)anObject ;
/// 删除元素
- (void)remove:(id<YHCompareProtocol>)element;


#pragma mark --- 子类继承的方法
/**
 添加元素之后的操作, 如AVL，红黑树
 @param node 添加的节点
 */
- (void)afterAdd:(__kindof YHBstNode *)node;
- (void)afterRemove:(__kindof YHBstNode *)node replaceNode:(__kindof YHBstNode *)replaceNode;
///新建节点.原因是子类需要不同的节点对象，而YHBinarySearchTree只会创建YHBstNode
- (__kindof YHBstNode *)createNodeWithElement:(id)ele parent:(YHBstNode *)parent;

@end

