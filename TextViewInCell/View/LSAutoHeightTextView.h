//
//  LSAutoHeightTextView.h
//  LSchedule
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSAutoHeightTextView : UITextView

// 最大行数，如果不赋值，那么不会自动增高
@property (nonatomic,assign)NSInteger numberOfLines;

/** 只有输入状态下，高度改变了的时候才会调用 */
@property (nonatomic, strong) void(^heightDidChangeBlock)(NSString *text,CGFloat height);

/** text 通过赋值变化后的回调 */
@property (nonatomic, copy) void (^textDidSetBlock)(NSString *text,CGFloat textHeight);

@end
