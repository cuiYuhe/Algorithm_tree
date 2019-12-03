//
//  main.m
//  AlgorithmTree
//
//  Created by cuiyuheMacAir on 2019/12/3.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBinarySearchTree.h"
#import "YHBook.h"
#import "MJBinaryTrees.h"
#import "YHAVLTree.h"
#import "YHRedBlackTree.h"

#import <Foundation/Foundation.h>

void testBinarySearchTree1(void);
void testBinarySearchTree2(void);
void testAVLTree(void);
void testRBTree(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testBinarySearchTree1();
        testBinarySearchTree2();
        testAVLTree();
        testRBTree();
    }
    return 0;
}

#pragma mark --- 测试
void testBinarySearchTree1(){
    NSArray *data = @[@10, @8, @1, @3, @5, @7];
    YHBinarySearchTree *tree = [YHBinarySearchTree new];
    for (id value in data) {
        [tree add:value];
    }
    [tree remove:(id<YHCompareProtocol>)@3];
    [MJBinaryTrees println:tree];
    printf("~~~~前序遍历:\n");
    [tree preorderTraversal];
    printf("~~~~中序遍历:\n");
    [tree inorderTraversal];
}

///09-二叉搜索树
void testBinarySearchTree2(){
    YHBook *b1 = [YHBook yh_bookWithPage:1 type:@"math"];
    YHBook *b2 = [YHBook yh_bookWithPage:2 type:@"chemistry"];
    YHBook *b3 = [YHBook yh_bookWithPage:3 type:@"physics"];
    YHBook *b4 = [YHBook yh_bookWithPage:4 type:@"english"];
    YHBook *b5 = [YHBook yh_bookWithPage:5 type:@"story"];
    YHBook *b6 = [YHBook yh_bookWithPage:6 type:@"iOS"];
    YHBook *b7 = [YHBook yh_bookWithPage:7 type:@"chinese"];
    
    NSArray *data = @[b7, b2, b3, b4, b5, b6, b1];
    YHBinarySearchTree *tree = [YHBinarySearchTree new];
    for (id value in data) {
        [tree add:value];
    }
    [tree remove:b3];
    [MJBinaryTrees println:tree];
    printf("~~~~前序遍历:\n");
    [tree preorderTraversal];
    printf("~~~~中序遍历:\n");
    [tree inorderTraversal];
}

///AVTree
void testAVLTree(){
    YHBook *b1 = [YHBook yh_bookWithPage:1 type:@"math"];
    YHBook *b2 = [YHBook yh_bookWithPage:2 type:@"chemistry"];
    YHBook *b3 = [YHBook yh_bookWithPage:3 type:@"physics"];
    YHBook *b4 = [YHBook yh_bookWithPage:4 type:@"english"];
    YHBook *b5 = [YHBook yh_bookWithPage:5 type:@"story"];
    YHBook *b6 = [YHBook yh_bookWithPage:6 type:@"iOS"];
    YHBook *b7 = [YHBook yh_bookWithPage:7 type:@"chinese"];
    
    NSArray *data = @[b7, b2, b3, b4, b5, b6, b1];
    YHAVLTree *tree = [YHAVLTree new];
    for (id value in data) {
        [tree add:value];
    }
    [tree remove:b3];
    [MJBinaryTrees println:tree];
}

///红黑树
void testRBTree(void){
    YHBook *b1 = [YHBook yh_bookWithPage:1 type:@"math"];
    YHBook *b2 = [YHBook yh_bookWithPage:2 type:@"chemistry"];
    YHBook *b3 = [YHBook yh_bookWithPage:3 type:@"physics"];
    YHBook *b4 = [YHBook yh_bookWithPage:4 type:@"english"];
    YHBook *b5 = [YHBook yh_bookWithPage:5 type:@"story"];
    YHBook *b6 = [YHBook yh_bookWithPage:6 type:@"iOS"];
    YHBook *b7 = [YHBook yh_bookWithPage:7 type:@"chinese"];
    
    NSArray *data = @[b7, b2, b3, b4, b5, b6, b1];
    YHRedBlackTree *tree = [YHRedBlackTree new];
    for (id value in data) {
        [tree add:value];
    }
    [tree remove:b3];
    [MJBinaryTrees println:tree];
}
