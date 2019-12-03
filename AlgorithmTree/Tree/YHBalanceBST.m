//
//  YHBalanceBST.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/9/15.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBalanceBST.h"

@implementation YHBalanceBST
/**
 左旋不平衡的祖父节点,当RR时。RR是指添加分支的节点相对于祖父节点来说的方向是：RR（右右）
 @param grand 祖父节点
 */
- (void)rotateLeft:(YHBstNode *)grand{
    YHBstNode *parent = grand.right;
    YHBstNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotate:grand parent:parent child:child];
}

/**
 右旋不平衡的祖父节点,当LL时。LL是指添加分支的节点相对于祖父节点来说的方向是：LL（左左）
 @param grand 祖父节点
 */
- (void)rotateRight:(YHBstNode *)grand{
    YHBstNode *parent = grand.left;
    YHBstNode *child = parent.right;
    parent.right = grand;
    grand.left = child;
    [self afterRotate:grand parent:parent child:child];
}


/**
 旋转祖先节点后的操作：
 1）需要更新祖先节点grand、父节点_parent、子节点_child 的父节点
 2）更新grand、parent的高度height
 
 @param grand 旋转的祖先节点
 @param parent 父节点
 @param child 最下面的节点
 */
- (void)afterRotate:(YHBstNode *)grand parent:(YHBstNode *)parent child:(YHBstNode *)child{
    //parent是grand的父节点了
    parent.parent = grand.parent;
    //更新再上一层节点的子节点
    if (grand.isLeftChild) {
        grand.parent.left = parent;
    }else if (grand.isRightChild) {
        grand.parent.right = parent;
    }else{ //原来grand是root
        self.root = parent;
    }
    grand.parent = parent;
    child.parent = grand;
    
    //更新高度
//    [self _updateNode:parent];
//    [self _updateNode:grand];
}
@end
