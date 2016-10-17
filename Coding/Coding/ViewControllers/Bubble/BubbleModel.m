#import "BubbleModel.h"

@implementation BubbleModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"str_description"  : @"description",
             @"n_id": @"id"};
}
- (void)setContent:(NSString *)content {
    _htmlMedia = [HtmlMedia htmlMediaWithString:content showType:MediaShowTypeNone];
    _content = _htmlMedia.contentDisplay;
    //
    //    NSMutableArray *array = [NSMutableArray array];
    //    if (_htmlMedia.imageItems.count >0) {
    //        for (int i=0; i<10; i++) {
    //            [array addObject:[_htmlMedia.imageItems firstObject]];
    //        }
    //    }
    //    _htmlMedia.imageItems = array;
}

- (CGFloat)varContentHeight {
    if (_varContentHeight < 0.0001) {
        
        CGFloat textWidth = kScreenWidth -15*2;
        CGFloat textHeight = [self.content boundingRectWithSize:CGSizeMake(textWidth, 999) options:(NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size.height;
        
        CGFloat imageHeight;
        NSInteger imageCount = self.htmlMedia.imageItems.count;
        if (imageCount == 0) {
            imageHeight = -15;
        } else if (imageCount == 1) {
            imageHeight = 192;
        } else if (imageCount == 2) {
            imageHeight = 95;
        } else if (imageCount == 4) {
            imageHeight = 95*2+5;
        } else {
            NSInteger space = (imageCount+2)/3;
            imageHeight = 95*space+5*(space-1);
        }
        
        CGFloat commentHeight;
        NSInteger commentCount = self.comment_list.count;
        
        if (commentCount > 6) {
            commentHeight = 47*6;
        } else {
            commentHeight = 47*commentCount;
        }
        
        NSInteger likeCount = self.like_users.count;
        if (likeCount > 0) {
            commentHeight += 52;
        } else {
            commentHeight += 7;
        }
        
        if (commentCount > 6) {
            commentHeight += 45;
        }
        
        if (commentCount == 0 && likeCount == 0) {
            commentHeight -= 15;
        }
        _varContentHeight = textHeight + imageHeight + commentHeight;
    }
    return _varContentHeight;
}

@end
