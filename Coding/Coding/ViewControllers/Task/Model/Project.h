#import "BasesModel.h"

@interface Project : BasesModel

@property (copy, nonatomic) NSNumber *recommended;
@property (assign, nonatomic, getter=isIs_Public) BOOL is_public;
@property (copy, nonatomic) NSString *owner_user_name;
@property (copy, nonatomic) NSNumber *status;
@property (copy, nonatomic) NSNumber *owner_id;
@property (copy, nonatomic) NSString *owner_user_picture;
@property (copy, nonatomic) NSNumber *watch_count;
@property (assign, nonatomic, getter=isPin) BOOL pin;
@property (copy, nonatomic) NSNumber *max_member;
@property (copy, nonatomic) NSString *backend_project_path;
@property (copy, nonatomic) NSNumber *updated_at;
@property (copy, nonatomic) NSNumber *fork_count;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSNumber *plan;
@property (assign, nonatomic, getter=isForked) BOOL forked;
@property (copy, nonatomic) NSString *owner_user_home;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *type;
@property (copy, nonatomic) NSNumber *un_read_activities_count;
@property (copy, nonatomic) NSNumber *n_id;
@property (assign, nonatomic, getter=isStared) BOOL stared;
@property (copy, nonatomic) NSNumber *current_user_role_id;
@property (copy, nonatomic) NSString *project_path;
@property (copy, nonatomic) NSNumber *star_count;
@property (copy, nonatomic) NSNumber *groupId;
@property (copy, nonatomic) NSNumber *created_at;
@property (assign, nonatomic, getter=isIsteam) BOOL isTeam;
@property (assign, nonatomic, getter=isWatched) BOOL watched;
@property (copy, nonatomic) NSString *str_description;

@end
