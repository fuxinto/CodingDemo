#import "BasesModel.h"
#import "Projects.h"

@interface Data : BasesModel

@property (copy, nonatomic) NSNumber *totalRow;
@property (strong, nonatomic) NSArray *list;
@property (copy, nonatomic) NSNumber *pageSize;
@property (copy, nonatomic) NSNumber *totalPage;
@property (copy, nonatomic) NSNumber *page;

@end
