//
//  LSTextViewCell.h
//  LSchedule
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSAutoHeightTextView.h"

@class LSTextViewCell;
@protocol LSTextViewCellDelegate <NSObject>

@optional
-(void)textViewCell:(LSTextViewCell*)cell textHeightChange:(NSString*)text;

-(void)textViewCell:(LSTextViewCell*)cell textChange:(NSString*)text;

@end

@interface LSTextViewCell : UITableViewCell<UITextViewDelegate>
/** <#description#> */
@property (nonatomic, weak) id<LSTextViewCellDelegate> delegate;

/** 最大字符数限制 */
@property (nonatomic) NSInteger maxNumberWords;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) LSAutoHeightTextView *textView;
@end
