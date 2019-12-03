//
//  YHBalanceBST.h
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/9/15.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBinarySearchTree.h"

NS_ASSUME_NONNULL_BEGIN

/**
 有恢复平衡功能的二叉搜索树
 */
@interface YHBalanceBST : YHBinarySearchTree

/**
 左旋不平衡的祖父节点,当RR时。RR是指添加分支的节点相对于祖父节点来说的方向是：RR（右右）
 @param grand 祖父节点
 */
- (void)rotateLeft:(YHBstNode *)grand;

/**
 右旋不平衡的祖父节点,当LL时。LL是指添加分支的节点相对于祖父节点来说的方向是：LL（左左）
 @param grand 祖父节点
 */
- (void)rotateRight:(YHBstNode *)grand;

/**
 旋转祖先节点后的操作：
 1）需要更新祖先节点grand、父节点_parent、子节点_child 的父节点
 2）更新grand、parent的高度height
 
 @param grand 旋转的祖先节点
 @param parent 父节点
 @param child 最下面的节点
 */
- (void)afterRotate:(YHBstNode *)grand parent:(YHBstNode *)parent child:(YHBstNode *)child;

@end

NS_ASSUME_NONNULL_END
