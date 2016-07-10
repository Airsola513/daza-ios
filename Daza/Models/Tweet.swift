import RealmSwift
import ObjectMapper

class Tweet: Object, Mappable {
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
    
}