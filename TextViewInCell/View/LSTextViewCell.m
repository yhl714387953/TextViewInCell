//
//  LSTextViewCell.m
//  LSchedule
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "LSTextViewCell.h"
#import "Masonry.h"
#import "UITextView+LSPlaceHolder.h"

@implementation LSTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.textView];

        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
//            make.right.equalTo(self.view.mas_right).offset(0);
        }];
        
        //顶部的约束优先级最高，那么会先改变约束优先级高的，这样避免了底部在输入的换行自适应是的上下跳动问题
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5).priority(999);
            make.height.mas_greaterThanOrEqualTo(@(14)).priority(888);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5).priority(777);
            make.left.equalTo(self.contentView.mas_left).offset(100 - 5);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
        /*  这里没有必要更新高度了 因为  高度的约束是mas_greaterThanOrEqualTo
        __weak typeof (self) weakSelf = self;
        self.textView.heightDidChangeBlock = ^(NSString *text, CGFloat height) {
            [weakSelf.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_greaterThanOrEqualTo(@(height)).priority(888);
        
            }];
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(textViewCell:textHeightChange:)]) {
                [weakSelf.delegate textViewCell:weakSelf textHeightChange:text];
            }
            
            [weakSelf layoutIfNeeded];
        };
        */
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (self.textView.text.length > self.maxNumberWords && self.maxNumberWords > 0) {
        self.textView.text = [self.textView.text substringToIndex:self.maxNumberWords - 1];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewCell:textChange:)]) {
        [self.delegate textViewCell:self textChange:self.textView.text];
    }
}


#pragma mark -
#pragma mark - getter
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textColor = [UIColor darkTextColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.text = @"标题";
    }
    
    return _label;
}

-(LSAutoHeightTextView *)textView{
    if (!_textView) {
        _textView = [[LSAutoHeightTextView alloc] initWithFrame:CGRectZero];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.numberOfLines = 1000;
        _textView.delegate = self;
        _textView.placeholder = @"请输入内容";
        
    }
    
    return _textView;
}

@end
