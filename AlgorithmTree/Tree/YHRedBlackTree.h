//
//  YHRedBlackTree.h
//  03-二叉树
//
//  Created by cuiyuheMacAir on 2019/9/15.
//  Copyright © 2019年 qinger. All rights reserved.
//

/**
 1. 节点是 RED 或者 BLACK
 2. 根节点是 BLACK
 3. 叶子节点 （外部节点，空）都是 BLACK
 4. RED 节点
 4.1 子节点都是 BLACK
 4.2 RED 节点的 parent 都是 BLACK
 4.3 从根节点到 叶子节点 的所有 路径上不能2 个连续的 RED 节点
 5. 从任一节点到 叶子节点 的 所有路径都包含相同数目BLACK
 
 */
#import "YHBalanceBST.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHRedBlackTree : YHBalanceBST

@end

NS_ASSUME_NONNULL_END
