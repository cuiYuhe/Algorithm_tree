//
//  YHAVLNode.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/31.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHAVLNode.h"

@implementation YHAVLNode

- (instancetype)init{
    if (self = [super init]) {
        _height = 1;
    }
    return self;
}


// avl节点的平衡因子
- (NSInteger)balanceFactor{
    YHAVLNode *left = (YHAVLNode *)self.left;
    YHAVLNode *right = (YHAVLNode *)self.right;
    NSInteger leftHeight = left == nil ? 0 : left.height;
    NSInteger rightHeight = right == nil ? 0 : right.height;
    return leftHeight - rightHeight;
}

- (void)updateHeight{
    YHAVLNode *left = (YHAVLNode *)self.left;
    YHAVLNode *right = (YHAVLNode *)self.right;
    NSInteger leftHeight = left == nil ? 0 : left.height;
    NSInteger rightHeight = right == nil ? 0 : right.height;
    self.height = 1 + MAX(leftHeight, rightHeight);
}

- (instancetype)tallerChild{
    YHAVLNode *left = (YHAVLNode *)self.left;
    YHAVLNode *right = (YHAVLNode *)self.right;
    NSInteger leftHeight = left == nil ? 0 : left.height;
    NSInteger rightHeight = right == nil ? 0 : right.height;
    if (leftHeight > rightHeight) {
        return left;
    }else if (rightHeight > leftHeight) {
        return right;
    }
    return self.isLeftChild ? left : right;
}



@end
