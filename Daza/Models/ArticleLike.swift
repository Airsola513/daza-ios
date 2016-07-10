import RealmSwift
import ObjectMapper

class ArticleLike: Object, Mappable {
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
    
}