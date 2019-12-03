//
//  YHBinaryTree.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/20.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBinaryTree.h"


@interface YHBinaryTree()

@end

@implementation YHBinaryTree

- (NSInteger)size {
    return _size;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (void)clear {
    self.root = nil;
    self.size = 0;
}


/// 前序遍历:根结点 ---> 左子树 ---> 右子树
- (void)preorderTraversal{
    [self preorderTraversal:self.root];
}

- (void)preorderTraversal:(YHBstNode *)node{
    if (!node) {
        return;
    }
    
    NSLog(@"%@", node.element);
    [self preorderTraversal:node.left];
    [self preorderTraversal:node.right];
}

/// 中序遍历: 左子树---> 根结点 ---> 右子树
- (void)inorderTraversal{
    [self inorderTraversal:self.root];
}

- (void)inorderTraversal:(YHBstNode *)node{
    if (!node) {
        return;
    }
    [self inorderTraversal:node.left];
    NSLog(@"%@", node.element);
    [self inorderTraversal:node.right];
}

///后序遍历: 左子树 ---> 右子树 ---> 根结点
- (void)postorderTraversal{
    [self postorderTraversal:self.root];
}

- (void)postorderTraversal:(YHBstNode *)node{
    if (!node) {
        return;
    }
    [self postorderTraversal:node.left];
    [self postorderTraversal:node.right];
    NSLog(@"%@", node.element);
}

///层序遍历
- (void)levelOrderTraveral{
    NSMutableArray *queue = [NSMutableArray array];
    if (self.root) {
        [queue addObject:self.root];
    }
    
    while (queue.count > 0) {
        YHBstNode *first = queue.firstObject;
        NSLog(@"%@", first.element);
        [queue removeObjectAtIndex:0];
        
        if (first.left) {
            [queue addObject:first.left];
        }
        if (first.right) {
            [queue addObject:first.right];
        }
        
    }
}


///是不是完全二叉树,是YES
- (BOOL)isCompleteBinaryTree{
    if (self==nil) {
        return NO;
    }
    
    //层序遍历来判断
    NSMutableArray *queue = [NSMutableArray arrayWithCapacity:self.size];
    if (self.root) {
        [queue addObject:self.root];
    }
    
    // 之后的节点应该都是叶子节点.说明当前遍历的节点的右节点为空
    BOOL isLeaf = NO;
    while (queue.count > 0) {
        YHBstNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        
        if (isLeaf && !node.isLeaf) {
            return NO;
        }
        
        if (node.left) {
            [queue addObject:node.left];
            
            if (node.right) {
                [queue addObject:node.right];
            }
        }else if (node.right) { //左分支为空,右分支有值
            return NO;
        }
        
        if (!node.right) {
            isLeaf = YES;
        }
    }
    return YES;
}


///前驱节点:中序遍历时的前一个节点
- (YHBstNode *)predecessorNodeOfNode:(YHBstNode *)node{
    if (!node) {return nil;}
    
    YHBstNode *target = node.left;
    if (target) { //有左子树,则前驱节点在左子树中 的最右节点
        while (target.right) {
            target = target.right;
        }
        return target;
    }
    
    //左子树为空,则从父节点找
    target = node;
    while (target.parent && target == target.parent.left) {
        target = target.parent;
    }
    
    //来到这里,表明:1.parent为空 2.target不是其父节点的左节点
    return target.parent;
}

///后驱节点:中序遍历时的后一个节点
- (YHBstNode *)successorNodeOfNode:(YHBstNode *)node{
    if (!node) {return nil;}
    
    YHBstNode *target = node.right;
    if (target) { //有右子树, 则在右子树的最左的节点
        while (target.left) {
            target = target.left;
        }
        return target;
    }
    
    // 没有右子树 ,则从父节点找
    target = node;
    while (target.parent && target == target.parent.right) {
        target = target.parent;
    }
    
    //来到这里,表明:1.parent为空 2.target不是其父节点的右节点
    return target.parent;
}

- (NSUInteger)height{
    //层序遍历来判断
    NSMutableArray *queue = [NSMutableArray arrayWithCapacity:self.size];
    if (self.root) {
        [queue addObject:self.root];
    }
    
    NSUInteger height = 0;
    NSUInteger levelSize = 1; //每一层的数量
    while (queue.count > 0) {
        YHBstNode *first = queue.firstObject;
        [queue removeObjectAtIndex:0];
        levelSize--;
        
        if (first.left) {
            [queue addObject:first.left];
        }
        if (first.right) {
            [queue addObject:first.right];
        }
        if (levelSize==0) {// 即将遍历下一层
            levelSize = queue.count;
            height++;
        }
    }
    return height;
}


#pragma mark --- 辅助方法
- (void)checkNullElement:(id)element {
    NSAssert(element == nil, @"添加节点不能为空!");
}

- (NSString *)description{
    NSMutableString *desc = [NSMutableString string];
    [self print:self.root desc:desc prefix:@""];
    return desc;
}

- (void)print:(YHBstNode *)node desc:(NSMutableString *)desc prefix:(NSString *)prefix{
    if (!node) {
        return;
    }
    [desc appendFormat:@"\n%@%@", prefix, node.element];
    static NSString *leftPrefix = @"L---";
    static NSString *rightPrefix = @"R---";
    [self print:node.left desc:desc prefix:[prefix stringByAppendingString:leftPrefix]];
    [self print:node.right desc:desc prefix:[prefix stringByAppendingString:rightPrefix]];
}

@end
