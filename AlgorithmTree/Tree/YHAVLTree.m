//
//  YHAVLTree.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/30.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHAVLTree.h"

/*
 旋转是用来恢复平衡，即左右子树高度之差<=1。旋转分为左旋、右旋。
 旋转的技巧就是：向相反方向旋转，即向右分支添加节点就左旋；向左分支添加节点就右旋
 根据添加节点相对于父节点及祖父节点的方向又有几种区别，需要旋转一次或两次
 */

@implementation YHAVLTree

#pragma mark --- 继承方法
- (void)afterAdd:(__kindof YHBstNode *)node{
    //添加的节点，肯定是叶子节点。寻找其失衡的父节点
    while ((node = node.parent) != nil) {
        if ([self _isBalanceNode:node]) {
            //更新节点的高度。因为添加节点后高度有了变化
            [self _updateHeight:node];
        }else{
            //恢复平衡
            [self _rebalance:node];
            break;
        }
    }
}

- (void)afterRemove:(__kindof YHBstNode *)node{
    while ((node = node.parent) != nil) {
        if ([self _isBalanceNode:node]) {
            //更新节点的高度。因为添加节点后高度有了变化
            [self _updateHeight:node];
        }else{
            //恢复平衡
            [self _rebalance:node];
        }
    }
}

- (YHBstNode *)createNodeWithElement:(id)ele parent:(YHBstNode *)parent{
    return [YHAVLNode yh_nodeWithElement:ele parent:parent];
}

#pragma mark --- private method

/**
 恢复平衡
 @param grand 最低的不平衡的祖父节点
 */
- (void)_rebalance:(YHBstNode *)grand{
    //拿到父节点与当前节点做旋转。都是较高的节点
    YHAVLNode *parent = [(YHAVLNode *)grand tallerChild];
    YHAVLNode *node = parent.tallerChild;
    if (parent.isLeftChild) {
        if (node.isLeftChild) {//LL
            [self rotateRight:grand];
        }else{//LR
            [self rotateLeft:parent];
            [self rotateRight:grand];
        }
    }else{
        if (node.isLeftChild) {//RL
            [self rotateRight:parent];
            [self rotateLeft:grand];
        }else{//RR
            [self rotateLeft:grand];
        }
    }
}

/**
 恢复平衡.根据旋转后最终的样子：a,b,c,d,e,f,g都在固定的位置，大小就是这个顺序
 @param grand 最低的不平衡的祖父节点
 */
- (void)_rebalance2:(YHBstNode *)grand{
    YHAVLNode *parent = [(YHAVLNode *)grand tallerChild];
    YHAVLNode *node = [(YHAVLNode *)parent tallerChild];
    if (parent.isLeftChild) {//L
        if (node.isLeftChild) { //LL
            [self _rotate:grand b:node c:node.right d:parent e:parent.right f:grand];
        }else{//LR
            [self _rotate:grand b:parent c:node.left d:parent e:node.right f:grand];
        }
        
    }else{//R
        if (node.isLeftChild) { //RL
            [self _rotate:grand b:grand c:node.left d:node e:node.right f:parent];
        }else{//RR
            [self _rotate:grand b:grand c:parent.left d:parent e:node.left f:node];
        }
    }

}

- (void)_rotate:(YHBstNode *)root b:(YHBstNode *)b c:(YHBstNode *)c d:(YHBstNode *)d e:(YHBstNode *)e f:(YHBstNode *)f{
    
    /*
     d是最上面的点，即相对于b,c,d,e,f的根结点
     */
    d.parent = root.parent;
    if (root.isLeftChild) {
        root.parent.left = d;
    }else if (root.isRightChild){
        root.parent.right = d;
    }else{
        self.root = d;
    }
    
    //b-c
    b.right = c;
    c.parent = b;
    [self _updateHeight:b];
    
    //e-f
    f.left = e;
    e.parent = f;
    [self _updateHeight:f];
    
    //b-d-f
    d.left = b;
    d.right = f;
    b.parent = d;
    f.parent = d;
    [self _updateHeight:d];
}

- (void)_updateHeight:(YHBstNode *)node{
    [(YHAVLNode *)node updateHeight];
}

///节点是否平衡
- (BOOL)_isBalanceNode:(YHBstNode *)node{
    return labs([(YHAVLNode *)node balanceFactor]) <= 1;
}

/**
 旋转祖先节点后的操作：
 1）需要更新祖先节点grand、父节点_parent、子节点_child 的父节点
 2）更新grand、parent的高度height
 
 @param grand 旋转的祖先节点
 @param parent 父节点
 @param child 最下面的节点
 */
- (void)_afterRotate:(YHBstNode *)grand parent:(YHBstNode *)parent child:(YHBstNode *)child{
    
    [super afterRotate:grand parent:parent child:child];
    //更新高度
    [self _updateNode:parent];
    [self _updateNode:grand];
}

///节点更新高度
- (void)_updateNode:(YHBstNode *)node{
    [(YHAVLNode *)node updateHeight];
}
@end
