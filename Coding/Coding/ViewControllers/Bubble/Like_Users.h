#import "BasesModel.h"
@interface Like_Users : BasesModel

@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSNumber *followed;
@property (copy, nonatomic) NSNumber *follow;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *global_key;
@property (copy, nonatomic) NSString *avatar;

@end
