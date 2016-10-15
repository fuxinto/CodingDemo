#import "BasesModel.h"
#import "Owner.h"
#import "HtmlMedia.h"

@interface Comment_List : BasesModel

@property (copy, nonatomic) NSNumber *n_id;
@property (copy, nonatomic) NSNumber *tweet_id;
@property (copy, nonatomic) NSNumber *owner_id;
@property (strong, nonatomic) Owner *owner;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSNumber *created_at;

@property (strong, nonatomic) HtmlMedia *htmlMeida;

@end
