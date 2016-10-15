#import "BubbleModel.h"

@implementation BubbleModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"str_description"  : @"description",
             @"n_id": @"id"};
}

//- (void)setContent:(NSString *)content {
//    _htmlMedia = [HtmlMedia htmlMediaWithString:content showType:MediaShowTypeAll];
//    _content = _htmlMedia.contentDisplay;
//}

@end
