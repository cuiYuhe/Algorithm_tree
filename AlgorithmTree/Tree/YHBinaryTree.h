//
//  YHBinaryTree.h
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/20.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHBstNode.h"


@interface YHBinaryTree : NSObject


/// 二叉树的高度
@property (nonatomic, assign, readonly) NSUInteger height;
/// 根节点
@property (nonatomic, strong) YHBstNode *root;
/// 大小
@property (nonatomic, assign) NSInteger size;



- (NSInteger)size;
- (BOOL)isEmpty;
- (void)clear;

///前序遍历:根结点 ---> 左子树 ---> 右子树
- (void)preorderTraversal;
///中序遍历: 左子树---> 根结点 ---> 右子树
- (void)inorderTraversal;
///后序遍历: 左子树 ---> 右子树 ---> 根结点
- (void)postorderTraversal;
///层序遍历
- (void)levelOrderTraveral;
///是不是完全二叉树,是YES
- (BOOL)isCompleteBinaryTree;
///前驱节点:中序遍历时的前一个节点
- (YHBstNode *)predecessorNodeOfNode:(YHBstNode *)node;
///后驱节点:中序遍历时的后一个节点
- (YHBstNode *)successorNodeOfNode:(YHBstNode *)node;


@end

