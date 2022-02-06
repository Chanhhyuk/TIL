// 이 앱의 Model 부분 데이터?부분
import Foundation
import UIKit


//Codable: JSON형식의 파일을 받아올 때 Swift로 변환해줌
// 인터넷에 있는 정보 API를 불러와서 그거에 맞는 데이터로 변환하여 사용
struct Pokemon {
    var name: String?       // 서버가 문제가 생기면 값을 못 받을수도 있기 때문에 경우를 고려해서 ?로 선언
    var imageUrl: String?
    var image: UIImage?
    var id: Int?
    var weight: Int?
    var height: Int?
    var defense: Int?
    var attack: Int?
    var description: String?
    var type:String?
    var baseExperience: Int?
    
    init(id: Int, dictionary: [String: AnyObject]){     // id와 dictionary를 초기화?
        
        self.id = id
                                                           // if let 바인딩
        if let name = dictionary["name"] as? String {      // dictionary에 name값이 있다면 name을 받아온다
            self.name = name
        }
        if let imageUrl = dictionary["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let weight = dictionary["weight"] as? Int {
            self.weight = weight
        }
        if let height = dictionary["height"] as? Int {
            self.height = height
        }
        if let defense = dictionary["defense"] as? Int {
            self.defense = defense
        }
        if let type = dictionary["type"] as? String {
            self.type = type
        }
        if let baseExperience = dictionary["baseExperience"] as? Int {
            self.baseExperience = baseExperience
        }
    }
    
}
