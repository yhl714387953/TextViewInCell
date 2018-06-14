//
//  LSAutoHeightTextView.m
//  LSchedule
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "LSAutoHeightTextView.h"

@interface LSAutoHeightTextView ()
@property (nonatomic,assign) NSInteger textHeight;
@property (nonatomic,assign) NSInteger maxHeight;
@property (nonatomic, strong) UILabel* placeholderLabel;

@end

@implementation LSAutoHeightTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    
    self.showsHorizontalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.enablesReturnKeyAutomatically = YES;
    
    self.maxNumOfLines = 5;
    self.font = [UIFont systemFontOfSize:14];
    
    //文本输入的时候才会响应
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChanged) name:UITextViewTextDidChangeNotification object:self];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:(CGRectMake(self.textContainerInset.left + 5, self.textContainerInset.top, 1000, 16))];
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    //    self.placeholderLabel.hidden = YES;
    [self addSubview:self.placeholderLabel];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == self && [keyPath isEqualToString:@"text"]) {
        [self textValueChanged];
    }
}

-(void)setTextHeightChangeBlock:(void (^)(NSString *, CGFloat))textHeightChangeBlock{
    _textHeightChangeBlock = textHeightChangeBlock;
    [self textValueChanged];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
}

- (void)textValueChanged{
    self.placeholderLabel.hidden = self.text.length != 0;
    
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (self.textHeight != height) { // 高度不一样，就改变了高度
        
        // 最大高度，可以滚动
        self.scrollEnabled = height > self.maxHeight && self.maxHeight > 0;
        self.textHeight = height;
        
        if (height > self.maxHeight) {
            height = self.maxHeight;
        }
        
        if (self.textHeightChangeBlock) {
            self.textHeightChangeBlock(self.text, height);
            [self.superview layoutIfNeeded];
        }
    }
}

-(void)setMaxNumOfLines:(NSInteger)maxNumOfLines{
    _maxNumOfLines = maxNumOfLines;
    // 超出这个最大高度时,就可以滚动；小于这个高度时,frame高度增加.
    self.maxHeight = ceil(self.font.lineHeight * maxNumOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"text"];
    @try {
        // [self removeObserver:self forKeyPath:@"text"];
    } @catch (NSException *exception) {
        // Do nothing
    }
}

@end
