#import "HFXUserInfoModel.h"
#import "YYModel.h"

static HFXUserInfoModel *userInfoModel = nil;
@implementation HFXUserInfoModel


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

+(instancetype)defaultInfo {
    if (!userInfoModel) {
        userInfoModel = [self unarchive];
    }
    return userInfoModel;
}

@end
