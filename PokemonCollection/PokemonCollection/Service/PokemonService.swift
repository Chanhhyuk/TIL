import UIKit

// API에 연결되어 분석한 모든 데이터를 반환한다.
class PokemonService {
    
    // static을 사용하여 단일 인스턴스 구현
    // 애플리케이션 전체에 API 호출을 많이 사용하지 않도록 해야함 메모리이슈가 생길 수 있음
    // 그래서 싱글톤으로 구현
    static let shared = PokemonService()        // 해당 클래스에서 사용하는 인스턴스를 공유한다
    
    let url = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    // API json으로 된것을 변환해서 사용해야함

    func fetchPokemons(completion: @escaping ([Pokemon]) -> () ){
        var pokemonArray = [Pokemon]()
        
        guard let url = URL(string: url) else { return }    // url 유효성 확인
        
        // URL 세션 시작
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // API 요청의 실패유무 확인
            if let error = error {
                print("오류로 인해 데이터를 가져오지 못했습니다!: ", error.localizedDescription)
                return
            }
            
            // API에서 반환할 데이터
            guard let data = data else { return }
            
            do {
                guard let resultArray = try JSONSerialization.jsonObject(with: data, options: []) as?  [AnyObject] else { return }
                // 원시데이터에서 JSON으로 변환한다.
                // 모든 객체유형의 배열로 캐스팅
                
                
                // API result가 타입이 String도 있고 Int형도 있고 여러타입이 있어서 AnyObject로 
                for (key, result) in resultArray.enumerated() {
                    if let dictionary = result as? [String: AnyObject] {
                        var pokemon = Pokemon(id: key, dictionary: dictionary)
                        guard let imageUrl = pokemon.imageUrl else { return }
                        self.fetchImage(withUrlString: imageUrl) { (image) in
                            pokemon.image = image
                            pokemonArray.append(pokemon)
                            
                            // 순서대로 다시 정렬하여 배열을 정렬
                            pokemonArray.sort { (poke1, poke2) in
                                return poke1.id! < poke2.id! // 이 시점에는 이미 id있는게 확신하기 때문에 !사용
                            }
                            
                            completion(pokemonArray)        // 완료블럭을 구현하여 빈블럭일때 앱이 다운되는것을 막는다?
                        }
                    }

                }
            } catch let error {
                print("json 생성을 실패하였습니다!: ", error.localizedDescription)
            }
        }.resume()
    }
    
    // 이미지를 가져오기 위한 함수
    private func fetchImage(withUrlString urlString: String, completion: @escaping(UIImage) -> ()){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("이미지 데이터를 받아오지 못했습니다!: ", error.localizedDescription)
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }.resume()
    }

}

//if let url = URL(string: url){      // 만약 url이 있다면
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        if let error = error { // 만약 에러가 발생한다면
//            print("에러가 발생했습니다.")
//            print(error.localizedDescription)
//        }else{      // 에러가 발생하지 않는다면
//            if let data = data {
//                do {
//                    let pokemons = try JSONDecoder().decode([Pokemon].self, from: data)
//                    DispatchQueue.main.async {  // 여기 만큼은 메인쓰레드에서 실행
//                        self.delegate?.pokemonService(pokemons: pokemons)
//                    }
//                }catch let error {
//                    print("에러가 발생했습니다!")
//                    print(error)
//                }
//            }
//        }
//    }.resume()      // 함수 실행
//}
