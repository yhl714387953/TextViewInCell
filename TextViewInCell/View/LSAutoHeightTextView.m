//
//  LSAutoHeightTextView.m
//  LSchedule
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "LSAutoHeightTextView.h"

@interface LSAutoHeightTextView ()
@property (nonatomic,assign)NSInteger textHeight;
@property (nonatomic,assign)NSInteger actualHeight;

@end

@implementation LSAutoHeightTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAttributes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initAttributes];
    }
    return self;
}

- (void)initAttributes{
    self.showsVerticalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.numberOfLines = 1;

    self.font = [UIFont systemFontOfSize:14];
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:self];
    
}

-(void)setHeightDidChangeBlock:(void (^)(NSString *, CGFloat))heightDidChangeBlock{
    _heightDidChangeBlock = heightDidChangeBlock;

    [self textDidChanged];
}

- (void)textDidChanged{
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (self.textHeight != height) { // 高度如果不一样，就换行改变了高度
        self.textHeight = height;
        // 超过最大高度，那么就可以滚动
        self.scrollEnabled = height > self.actualHeight && self.actualHeight > 0;

        if (self.heightDidChangeBlock && self.scrollEnabled == NO) {
            self.heightDidChangeBlock(self.text,height);
            [self.superview layoutIfNeeded];
            
        }
        
    }
}


-(void)setNumberOfLines:(NSInteger)numberOfLines{
    _numberOfLines = numberOfLines;
    
    //向上取整，同时要注意内容的显示在视图内的上下padding
    self.actualHeight = ceil(self.font.lineHeight * numberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
