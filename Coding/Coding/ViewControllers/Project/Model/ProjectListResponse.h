#import "BasesModel.h"
#import "Data.h"

@interface ProjectListResponse : BasesModel

@property (strong, nonatomic) Data *data;
@property (copy, nonatomic) NSNumber *code;

@end
