//
//  YHRedBlackTree.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/9/15.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHRedBlackTree.h"

static BOOL const RED = NO;
static BOOL const BLACK = YES;

@interface YHRedBlackNode : YHBstNode

/// 当前节点颜色
@property (nonatomic, assign) BOOL color;

@end

@implementation YHRedBlackNode

+ (YHBstNode *)yh_nodeWithElement:(id)ele parent:(YHBstNode *)parent{
    YHRedBlackNode *node = [super yh_nodeWithElement:ele parent:parent];
    node.color = RED;
    return node;
}

- (NSString *)description{
    NSString *desc = @"";
    if (self.color == RED) {
        desc = @"R_";
    }
    return [desc stringByAppendingString:self.element.description]; 
}

@end

@implementation YHRedBlackTree

- (void)afterAdd:(__kindof YHRedBlackNode *)node{
    /**
     添加的默认节点为RED,这样只需要处理下面的特点(其它特点都符合):
     4. RED 节点的子节点都是 BLACK
     4.1 RED 节点的 parent 都是 BLACK
     4.2 从根节点到 叶子节点 的所有 路径上不能2 个连续的 RED 节点
     
     添加一共有12种情况:
     1.父节点为黑色,有4种情况,不需要处理
     2.父节点为红色,有8种情况,需要处理
     */
    YHRedBlackNode *parent = (YHRedBlackNode *)node.parent;

    if (parent == nil) {
        [self _colorWithNode:node color:BLACK]; //根节点为黑色
        return;
    }
    
    if ([self _isBlackOfNode:parent]) {
        return;
    }
    
    /*
     下面是父节点是红色节点的情况,此时又分成两种情况:添加节点的叔父节点是不是红色,
     */
    YHRedBlackNode *uncle = (YHRedBlackNode *)node.parent.siblingNode;
    
    // 红色节点: 1.新添加的节点 2.旋转后变成了子节点(不是根节点)
    YHRedBlackNode *grand = (YHRedBlackNode *)[self _redWithNode:(YHRedBlackNode *)parent.parent];

    if ([self _isRedOfNode:uncle]) {// 叔父节点是红色【B树节点上溢】,已经4个节点
        [self _blackWithNode:parent];
        [self _blackWithNode:uncle];
        
        [self afterAdd:grand];
        return;
    }
    
    //叔父节点不是红色
    if (parent.isLeftChild) { //L
        if (node.isLeftChild) {//LL
            [self _blackWithNode:parent];
        }else{//LR
            [self _blackWithNode:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
        
    }else{ //R
        if (node.isLeftChild) {//RL
            [self _blackWithNode:node];
            [self rotateRight:parent];
        }else{//RR
            [self _blackWithNode:parent];
        }
        [self rotateLeft:grand];
    }
}

- (void)afterRemove:(__kindof YHBstNode *)node replaceNode:(__kindof YHBstNode *)replaceNode{
    /*
     最后实际删除的点,即清理内存的节点是叶子节点.
     传进来的node,即为实际删除的节点,
     如果删除的节点是红色; 或者替代的节点是红色
     */
    if ([self _isRedOfNode:node]) { //删除的红色节点
        return;
    }
    
    if ([self _isRedOfNode:replaceNode]) { //替代的节点是红色节点
        [self _blackWithNode:replaceNode];
        return;
    }
    YHRedBlackNode *parent = (YHRedBlackNode *)node.parent;
    if (parent == nil) { //删除的是根结点
        return;
    }
    
    //删除的是黑色叶子节点,即下溢
    /*
     判断被删除的节点是左还是右
     1.当父类调用时,父节点会将这个node清除,所以用父节点的哪边为空判断
     2.当自身递归调用时,父节点的左指针未清空
     */
    BOOL isLeft = parent.left == nil || node.isLeftChild;
    YHBstNode *sibling = isLeft ? parent.right : parent.left;
    
    //注:下面两种情况的代码是对称的
    if (isLeft) {//被删除的节点在左边
        if ([self _isRedOfNode:sibling]) {
            [self _blackWithNode:sibling];
            [self _redWithNode:parent];
            [self rotateLeft:parent];
            
            //更换兄弟
            sibling = parent.right;
        }
        
        //兄弟节点是黑色
        BOOL isLeftRed = [self _isRedOfNode:sibling.left];
        BOOL isRightRed = [self _isRedOfNode:sibling.right];
        if (isLeftRed || isRightRed) { //至少有一个红色节点
            
            if ([self _isBlackOfNode:sibling.right]){
                //兄弟节点是黑色,左旋转. 旋转后就是LL的情况
                [self rotateRight:sibling];
                sibling = parent.right; //旋转后,兄弟节点改变
            }
            
            [self _colorWithNode:sibling color:[self _colorOfNode:parent]];
            [self _blackWithNode:sibling.right];
            [self _blackWithNode:parent];
            [self rotateLeft:parent];
            
            
        }else{ //没有红色节点
            BOOL isParentBlack = [self _isBlackOfNode:node.parent];
            [self _blackWithNode:parent];
            [self _redWithNode:sibling];
            if (isParentBlack) {
                [self afterRemove:parent replaceNode:nil];
            }
        }
        
    }else{ //被删除的节点在右边
        if ([self _isRedOfNode:sibling]) {
            [self _blackWithNode:sibling];
            [self _redWithNode:parent];
            [self rotateRight:parent];
            
            //更换兄弟
            sibling = parent.left;
        }
        
        //兄弟节点是黑色
        BOOL isLeftRed = [self _isRedOfNode:sibling.left];
        BOOL isRightRed = [self _isRedOfNode:sibling.right];
        if (isLeftRed || isRightRed) { //至少有一个红色节点
            
            if ([self _isBlackOfNode:sibling.left]){
                //兄弟节点是黑色,左旋转. 旋转后就是LL的情况
                [self rotateLeft:sibling];
                sibling = parent.left; //旋转后,兄弟节点改变
            }
            
            [self _colorWithNode:sibling color:[self _colorOfNode:parent]];
            [self _blackWithNode:sibling.left];
            [self _blackWithNode:parent];
            [self rotateRight:parent];
            
        }else{ //没有红色节点
            BOOL isParentBlack = [self _isBlackOfNode:node.parent];
            [self _blackWithNode:parent];
            [self _redWithNode:sibling];
            if (isParentBlack) {
                [self afterRemove:parent replaceNode:nil];
            }
        }
    }
}

- (YHBstNode *)createNodeWithElement:(id)ele parent:(YHBstNode *)parent{
    return [YHRedBlackNode yh_nodeWithElement:ele parent:parent];
}


#pragma mark --- private
///染成红色
- (YHBstNode *)_redWithNode:(YHBstNode *)node{
    return [self _colorWithNode:node color:RED];
}

///染成黑色
- (YHBstNode *)_blackWithNode:(YHBstNode *)node{
    return [self _colorWithNode:node color:BLACK];
}

///染色
- (YHBstNode *)_colorWithNode:(YHBstNode *)node color:(BOOL)color{
    YHRedBlackNode *rbNode = (YHRedBlackNode *)node;
    rbNode.color = color;
    return node;
}

- (BOOL)_isBlackOfNode:(YHBstNode *)node{
    return [self _colorOfNode:node] == BLACK;
}

- (BOOL)_isRedOfNode:(YHBstNode *)node{
    return [self _colorOfNode:node] == RED;
}

- (BOOL)_colorOfNode:(YHBstNode *)node{
    YHRedBlackNode *rbNode = (YHRedBlackNode *)node;
    return node == nil ? BLACK : rbNode.color;
}

#pragma mark - MJBinaryTreeInfo
- (id)string:(YHRedBlackNode *)node {
    NSString *color = @"RED";
    if (node.color == BLACK) {
        color = @"BLACK";
    }
    return [NSString stringWithFormat:@"%@-%@", color, node.element];
}

@end







