#import "BasesModel.h"

@interface HFXUserInfoModel : BasesModel

// 获取自身对象
+(instancetype)defaultInfo;

@property (copy, nonatomic) NSString *lavatar;
@property (copy, nonatomic) NSString *last_activity_at;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *company;
@property (copy, nonatomic) NSString *is_member;
@property (copy, nonatomic) NSString *str_id;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *phone_country_code;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *slogan;
@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSString *tweets_count;
@property (copy, nonatomic) NSString *is_phone_validated;
@property (copy, nonatomic) NSString *name_pinyin;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *introduction;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *followed;
@property (copy, nonatomic) NSString *email_validation;
@property (copy, nonatomic) NSString *tags;
@property (copy, nonatomic) NSString *gravatar;
@property (copy, nonatomic) NSString *fans_count;
@property (copy, nonatomic) NSString *job;
@property (copy, nonatomic) NSString *updated_at;
@property (copy, nonatomic) NSString *follows_count;
@property (copy, nonatomic) NSString *last_logined_at;
@property (copy, nonatomic) NSString *tags_str;
@property (copy, nonatomic) NSString *points_left;
@property (copy, nonatomic) NSString *follow;
@property (copy, nonatomic) NSString *phone_validation;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *global_key;
@end
