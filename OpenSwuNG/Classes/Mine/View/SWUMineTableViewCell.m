//
//  SWUMineTableViewCell.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/19.
//

#import "SWUMineTableViewCell.h"
#import "swuMineModel.h"


@implementation SWUMineTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)setSwuMine:(SWUMineModel *)swuMine {
    _swuMine = swuMine;
    self.imageView.image = [UIImage imageNamed:swuMine.icon];
    self.textLabel.text = swuMine.content;
}


@end
