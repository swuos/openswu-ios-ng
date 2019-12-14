//
//  SWULostCell.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/16.
//

#import "SWULostCell.h"
#import "SWULostModel.h"
#import "Masonry.h"

@implementation SWULostCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.numberOfLines = 0;
        [self.imageView removeFromSuperview];
    }
    return self;
}

- (void)setModel:(SWULostModel *)model {
    _model = model;
    self.textLabel.text = model.text;
    self.detailTextLabel.text = model.pubTime;
}

-(void)layoutSubviews {
    
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom).offset(10);
        make.left.equalTo(self.textLabel);
    }];
//    top, left, bottom, right
//    [self setSeparatorInset:UIEdgeInsetsMake(0,self.textLabel.frame.origin.x,0,self.textLabel.frame.origin.x)];
//    NSLog(@"%lf-----",self.textLabel.frame.origin.x);
//    self.separatorInset = ;
//    CGRect rect = self.detailTextLabel.frame;
//    self.detailTextLabel.frame = CGRectMake(rect.origin.x, CGRectGetMaxY(self.textLabel.frame) + 50, rect.size.width, rect.size.width);
    [super layoutSubviews];
}

@end
