import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String? = ""//id
    @objc dynamic var old: String? = ""//年齢
    @objc dynamic var adana: String? = ""//あだ名
    @objc dynamic var sex: String? = ""//性別
    override static func primaryKey() -> String? {
            return "name"
}
}
