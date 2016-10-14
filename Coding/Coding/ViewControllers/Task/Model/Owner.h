#import "BasesModel.h"
@interface Owner : BasesModel

@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSNumber *status;
@property (copy, nonatomic) NSString *gravatar;
@property (copy, nonatomic) NSNumber *last_logined_at;
@property (copy, nonatomic) NSString *company;
@property (copy, nonatomic) NSNumber *fans_count;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSNumber *updated_at;
@property (copy, nonatomic) NSNumber *sex;
@property (copy, nonatomic) NSString *phone_country_code;
@property (assign, nonatomic, getter=isFollowed) BOOL followed;
@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSNumber *points_left;
@property (copy, nonatomic) NSString *global_key;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *is_member;
@property (copy, nonatomic) NSNumber *tweets_count;
@property (copy, nonatomic) NSString *lavatar;
@property (copy, nonatomic) NSString *name_pinyin;
@property (copy, nonatomic) NSString *slogan;
@property (copy, nonatomic) NSNumber *n_id;
@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSNumber *follows_count;
@property (copy, nonatomic) NSString *introduction;
@property (copy, nonatomic) NSNumber *created_at;
@property (assign, nonatomic, getter=isFollow) BOOL follow;

@end
