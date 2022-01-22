// 이 앱의 Model 부분 데이터?부분
import Foundation
import UIKit

struct Pokemon {    //Codable: JSON형식의 파일을 받아올 때 Swift로 변환해줌
    var name: String?
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
        
        if let name = dictionary["name"] as? String {
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
