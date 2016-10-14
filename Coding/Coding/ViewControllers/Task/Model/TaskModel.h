#import "BasesModel.h"
#import "Creator.h"
#import "Owner.h"
#import "Project.h"

@interface TaskModel : BasesModel

@property (copy, nonatomic) NSNumber *n_id;
@property (copy, nonatomic) NSNumber *comments;
@property (strong, nonatomic) Project *project;
@property (copy, nonatomic) NSNumber *created_at;
@property (copy, nonatomic) NSNumber *current_user_role_id;
@property (copy, nonatomic) NSNumber *priority;
@property (assign, nonatomic, getter=isWatch) BOOL watch;
@property (strong, nonatomic) Owner *owner;
@property (copy, nonatomic) NSNumber *owner_id;
@property (strong, nonatomic) Creator *creator;
@property (copy, nonatomic) NSNumber *number;
@property (copy, nonatomic) NSNumber *creator_id;
@property (copy, nonatomic) NSNumber *project_id;
@property (copy, nonatomic) NSNumber *updated_at;
@property (assign, nonatomic, getter=isHas_Description) BOOL has_description;
@property (copy, nonatomic) NSNumber *status;
@property (copy, nonatomic) NSString *content;


//@property (copy, nonatomic)

@end
