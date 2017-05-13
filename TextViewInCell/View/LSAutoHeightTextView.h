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

// 用于传值的block
@property (nonatomic, strong) void(^heightDidChangeBlock)(NSString *text,CGFloat height);

@end
