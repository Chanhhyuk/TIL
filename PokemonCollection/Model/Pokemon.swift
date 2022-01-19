import Foundation

struct Pokemon:Codable {    // JSON형식의 파일을 받아올 때 Swift로 변환해줌
    var name: String?
    var imageUrl: String?
    var type:String?
    var attack: Int?
    var defense: Int?
    
}
