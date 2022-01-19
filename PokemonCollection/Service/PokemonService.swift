import Foundation

protocol PokemonServiceProtocol {
    func pokemonService(pokemons:[Pokemon])
}

class PokemonService {
    let url = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    var delegate:PokemonServiceProtocol?

    func fetchPokemons(){
        if let url = URL(string: url){      // 만약 url이 있다면
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error { // 만약 에러가 발생한다면
                    print("에러가 발생했습니다.")
                    print(error.localizedDescription)
                }else{      // 에러가 발생하지 않는다면
                    if let data = data {
                        do {
                            let pokemons = try JSONDecoder().decode([Pokemon].self, from: data)
                            DispatchQueue.main.async {  // 여기 만큼은 메인쓰레드에서 실행
                                self.delegate?.pokemonService(pokemons: pokemons)
                            }
                        }catch let error {
                            print("에러가 발생했습니다!")
                            print(error)
                        }
                    }
                }
            }.resume()      // 함수 실행
        }
    }

}
