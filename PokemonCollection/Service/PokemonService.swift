import Foundation

protocol PokemonServiceProtocol {
    func pokemonService(pokemons:[Pokemon])
}

class PokemonService {
    
    static let shared = PokemonService()        // 여기 클래스를 인스턴스를 공유?
    let url = "https://pokedex-bb36f.firebaseio.com/pokemon.json"

    func fetchPokemons(){
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("데이터를 받아오지 못했습니다!: ", error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                guard let resultArray = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else { return }
                for (key, result) in resultArray.enumerated() {
                    if let dictionary = result as? [String: AnyObject] {
                        let pokemon = Pokemon(id: key, dictionary: dictionary)
                        print(pokemon.name)
                    }
                }
            } catch let error {
                print("json 생성을 실패하였습니다!: ", error.localizedDescription)
            }
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
