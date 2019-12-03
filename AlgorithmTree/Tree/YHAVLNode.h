//
//  YHAVLNode.h
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/8/31.
//  Copyright © 2019年 qinger. All rights reserved.
//

#import "YHBstNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHAVLNode : YHBstNode

/// 节点的高度
@property (nonatomic, assign) NSUInteger height;

// avl节点的平衡因子
- (NSInteger)balanceFactor;
- (void)updateHeight;
- (__kindof YHAVLNode *)tallerChild;

@end

NS_ASSUME_NONNULL_END
