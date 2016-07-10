import RealmSwift
import ObjectMapper

class Tag: Object, Mappable {
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {

    }

}