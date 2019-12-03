//
//  YHBinarySearchTree.m
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/20.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBinarySearchTree.h"

@interface YHBinarySearchTree()

@end

@implementation YHBinarySearchTree

#pragma mark --- 子类继承的方法
- (void)afterAdd:(__kindof YHBstNode *)node{}
- (void)afterRemove:(__kindof YHBstNode *)node replaceNode:(__kindof YHBstNode *)replaceNode{}
///新建节点.原因是子类需要不同的节点对象，而YHBinarySearchTree只会创建YHBstNode
- (__kindof YHBstNode *)createNodeWithElement:(id)ele parent:(YHBstNode *)parent{
    return [YHBstNode yh_nodeWithElement:ele parent:parent];
}

#pragma mark --- public method
- (void)add:(id<YHCompareProtocol>)element {
    [self checkNullElement:element];
    
    YHBstNode *node = self.root;
    YHBstNode *parent = self.root;
    BOOL isLeft = YES;
    
    YHBstNode *newNode = nil;
    if (self.size == 0) {
        newNode = [self createNodeWithElement:element parent:node];
        self.root = newNode;
    }else{
        
        while (node) {
            parent = node;
            if ([element compare:node.element] == NSOrderedDescending) {
                node = node.right;
                isLeft = NO;
            }else if ([element compare:node.element] == NSOrderedAscending){
                node = node.left;
                isLeft = YES;
            }else{ //相等,新值替代旧值
                node.element = element;
                return;
            }
        }
        
        newNode = [self createNodeWithElement:element parent:parent];
        if (isLeft) {
            parent.left = newNode;
        }else{
            parent.right = newNode;
        }
    }
    
    self.size++;
    [self afterAdd:newNode];
}

/// 外界调用删除元素,外界不知道节点的存在
- (void)remove:(id<YHCompareProtocol>)element {
    if (!element) return;
    [self _remove:[self _fetchNodeOfElement:element]];
}

- (void)_remove:(YHBstNode *)node {
    if (!node) { return; }
    
    self.size--;
    if (node.isTwoDegrees) { //度为2
        //找到后继节点代替root
        YHBstNode *suc = [self successorNodeOfNode:node];
        node.element = suc.element;
        node = suc;// 删除后继节点,即删除node.
    }
    //替换node的节点
    YHBstNode *replaceNode = node.left ? : node.right;
    if (replaceNode) { // 度为1
        replaceNode.parent = node.parent;
        
        if (node.parent == nil) {
            self.root = replaceNode;
        }else if (node == node.parent.left) {
            node.parent.left = replaceNode;
        }else{
            node.parent.right = replaceNode;
        }
        
        //删除的节点是replaceNode
        [self afterRemove:node replaceNode:replaceNode];
        
    }else { //度为0: node是叶子节点
        if (node.parent == nil) { //node是叶子节点,也是root
            self.root = nil;
        }else{
            if (node == node.parent.left) {
                node.parent.left = nil;
            }else if (node == node.parent.right) {
                node.parent.right = nil;
            }
        }
        
        [self afterRemove:node replaceNode:nil];
    }
}

///得到元素的节点
- (YHBstNode *)_fetchNodeOfElement:(id<YHCompareProtocol>)element{
    if (!element) return nil;
    
    YHBstNode *node = self.root;
    while (node) {
        NSComparisonResult result = [node.element compare:element];
        if (result == NSOrderedSame) {
            return node;
        }else if (result == NSOrderedAscending) {//升序
            node = node.right;
        }else{
            node = node.left;
        }
    }
    return nil;
}

- (BOOL)contains:(id)anObject {
    return [self _fetchNodeOfElement:anObject] != nil;
}


#pragma mark --- 辅助方法
- (void)checkNullElement:(id)element {
    NSAssert(element != nil, @"添加节点不能为空!");
}


#pragma mark - MJBinaryTreeInfo
- (id)left:(YHBstNode *)node {
    return node.left;
}

- (id)right:(YHBstNode *)node {
    return node.right;
}

- (id)string:(YHBstNode *)node {
    return node.element;
}

- (id)root {
    return [super root];
}
@end
