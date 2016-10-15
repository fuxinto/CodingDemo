#import "Comment_List.h"

@implementation Comment_List


#pragma mark - Custom Accessors

- (void)setContent:(NSString *)content {
    _htmlMeida = [HtmlMedia htmlMediaWithString:content showType:MediaShowTypeAll];
    _content = _htmlMeida.contentDisplay;
}

@end
