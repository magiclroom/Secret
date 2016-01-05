//
//  NKHostPostModel.m
//  NKCar
//
//  Created by J on 15/11/4.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKHostPostModel.h"

@implementation NKHostPostModel

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        CGFloat margin = 10;
        
        //头像
        CGFloat iconX = margin;
        CGFloat iconY = margin;
        CGFloat iconWH = 30;
        self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
        
        
        //昵称
        CGFloat nameX = CGRectGetMaxX(self.iconFrame) + margin;
        CGFloat nameY = iconY + 5;
        NSDictionary *nameAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGSize nameSize = [self.name sizeWithAttributes:nameAttrs];
        self.nameFrame = (CGRect){{nameX,nameY},nameSize};
        
        
        //vip
        if (self.vip) {
            CGFloat vipX = CGRectGetMaxX(self.nameFrame) + margin;
            CGFloat vipY = nameY;
            CGFloat vipW = 14;
            CGFloat vipH = nameSize.height;
            self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
        }
        
        
        //更多
        CGFloat moreX = 340;
        CGFloat moreY = iconY;
        CGFloat moreW = 20;
        CGFloat moreH = moreW;
        self.moreFrame = CGRectMake(moreX, moreY, moreW, moreH);
        
        
        //正文
        CGFloat textX = iconX;
        CGFloat textY = CGRectGetMaxY(self.iconFrame) + margin;
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * margin;
        CGSize textMaxSize = CGSizeMake(textW, MAXFLOAT);
        NSDictionary *textAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat textH = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size.height;
        self.textFrame = CGRectMake(textX, textY, textW, textH);
        
        
        //图片
        if (self.picture) {
            CGFloat pictureX = textX + margin;
            CGFloat pictureY = CGRectGetMaxY(self.textFrame) + margin;
            CGFloat pictureWH = 150;
            self.pictureFrame = CGRectMake(pictureX, pictureY, pictureWH, pictureWH);
            
            
            CGFloat interactionViewX = 0;
            CGFloat interactionViewY = CGRectGetMaxY(self.pictureFrame) + margin;
            CGFloat interactionViewW = NKSCREEN_W;
            CGFloat interactionViewH = 20;
            self.interactionViewFrame = CGRectMake(interactionViewX, interactionViewY, interactionViewW, interactionViewH);
            
            _cellHeight = CGRectGetMaxY(self.interactionViewFrame) + 2 * margin;
            
        }else {
            
            CGFloat interactionViewX = 0;
            CGFloat interactionViewY = CGRectGetMaxY(self.textFrame) + margin;
            CGFloat interactionViewW = NKSCREEN_W;
            CGFloat interactionViewH = 20;
            self.interactionViewFrame = CGRectMake(interactionViewX, interactionViewY, interactionViewW, interactionViewH);
            _cellHeight = CGRectGetMaxY(self.interactionViewFrame) + 2 * margin;
        }
        
    }
    return _cellHeight;
}


@end
