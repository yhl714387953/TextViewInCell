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

/*
 如果外部实现了textView.heightDidChangeBlock，那么这个协议是不会执行的(因为这个block是在cell创建时候赋值的)
 不管外部实现 textView.heightDidChangeBlock 还是调用了这个协议方法，都需要调用tableview的如下两个方法，连着调用即可
    [tableView beginUpdates];
    [tableView endUpdates];
*/
-(void)textViewCell:(LSTextViewCell*)cell textHeightChange:(NSString*)text;

-(void)textViewCell:(LSTextViewCell*)cell textChange:(NSString*)text;

@end

@interface LSTextViewCell : UITableViewCell<UITextViewDelegate>

/** 代理 */
@property (nonatomic, weak) id<LSTextViewCellDelegate> delegate;

/** 最大字符数限制 */
@property (nonatomic) NSInteger maxNumberWords;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) LSAutoHeightTextView *textView;
@end
