#import "BasesModel.h"
#import "Like_Users.h"
#import "Comment_List.h"
#import "Owner.h"
//#import "HtmlMedia.h"

@interface BubbleModel : BasesModel

@property (copy, nonatomic) NSNumber *n_id;
@property (copy, nonatomic) NSNumber *comments;
@property (copy, nonatomic) NSNumber *rewards;
@property (strong, nonatomic) NSArray *reward_users;
@property (strong, nonatomic) Owner *owner;
@property (copy, nonatomic) NSNumber *created_at;
@property (copy, nonatomic) NSNumber *likes;
@property (strong, nonatomic) NSArray *comment_list;
@property (copy, nonatomic) NSString *coord;
@property (copy, nonatomic) NSNumber *activity_id;
@property (copy, nonatomic) NSNumber *owner_id;
@property (copy, nonatomic) NSNumber *sort_time;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *address;
@property (strong, nonatomic) NSArray *like_users;
@property (assign, nonatomic, getter=isLiked) BOOL liked;
@property (copy, nonatomic) NSString *device;
@property (assign, nonatomic, getter=isRewarded) BOOL rewarded;
@property (copy, nonatomic) NSString *content;

//@property (strong, nonatomic) HtmlMedia *htmlMedia;
@end
