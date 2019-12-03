//
//  YHBstNode.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/20.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBstNode.h"

@implementation YHBstNode

+ (YHBstNode *)yh_nodeWithElement:(id)ele parent:(YHBstNode *)parent {
    YHBstNode *node = [[self alloc] init];
    node.parent = parent;
    node.element = ele;
    
    return node;
}

///兄弟节点
- (YHBstNode *)siblingNode{
    if ([self isLeftChild]) {
        return self.parent.right;
    }else if([self isRightChild]){
        return self.parent.left;
    }
    return nil;
}

- (BOOL)isLeftChild{
    return self == self.parent.left;
}
- (BOOL)isRightChild{
    return self == self.parent.right;
}

///是不是叶子节点
- (BOOL)isLeaf {
    return self.left == nil && self.right == nil;
}

/// 是否度为2
- (BOOL)isTwoDegrees{
    return self.left != nil && self.right != nil;
}

@end
