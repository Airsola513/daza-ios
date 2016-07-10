import RealmSwift
import ObjectMapper

class EventMember: Object, Mappable {
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
    
}