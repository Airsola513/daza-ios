import RealmSwift
import ObjectMapper

class Article: Object, Mappable {
    
    dynamic var user_id;        // 用户Id
    dynamic var topic_id;       // 主题Id
    dynamic var type;           // 类型
    dynamic var title;          // 标题
    dynamic var summary;        // 摘要
    dynamic var content;        // 内容
    dynamic var author;         // 作者
    dynamic var author_link;    // 作者链接
    dynamic var source;         // 来源
    dynamic var source_link;    // 来源链接
    dynamic var like_count;     // 喜欢数
    dynamic var comment_count;  // 评论数
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
    
}