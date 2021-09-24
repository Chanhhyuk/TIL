import UIKit
import CoreLocation // 주변 아이비컨과 관련된 지리적 위치 서비스를 제공


// 테이블 뷰를 사용하기 위해서는 UITableViewDelegate, UITableViewDataSource 프로토콜을 사용해야 한다.
// CLLocationManagerDelegate
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    // 테이블 뷰의 행의개수 위에서부터 한줄씩의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    // cell의 갯수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(to: models[indexPath.row])
        return cell
    }
    
    @IBOutlet var table: UITableView! // 스토리보드에 만들어 놓은 테이블 뷰를 연결함
    
    var models = [DailyWeatherEntry]()
    let locationManger = CLLocationManager()
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    
    func setupLocation() {
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManger.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }

    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(lat),\(long)?exclude=[flags,minutely]"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            // Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // Convert data to models/some object
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            guard let result = json else {
                return
            }
            
            let entries = result.daily.data
            
            self.models.append(contentsOf: entries)
            // update user interface
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
        }).resume()
    }
    
    struct WeatherResponse: Codable {
        let latitude: Float
        let longitude: Float
        let timezone: String
        let currently: CurrentWeather
        let hourly: HourlyWeather
        let daily: DailyWeather
        let offset: Float
    }
    
    struct CurrentWeather: Codable{
        let time: Int
        let summary: String
        let icon: String
        let nearestStormDistance: Int
        let nearestStormBearing: Int
        let precipIntensity: Int
        let precipProbability: Int
        let temperature: Double
        let apparentTemperature: Double
        let dewPoint: Double
        let humidity: Double
        let pressure: Double
        let windSpeed: Double
        let windGust: Double
        let windBearing: Int
        let cloudCover: Double
        let uvIndex: Int
        let visibility: Double
        let ozone: Double
    }
    
    struct DailyWeather: Codable {
        let summary: String
        let icon: String
        let data: [DailyWeatherEntry]
    }
    struct DailyWeatherEntry: Codable {
        let time: Int
        let summary: String
        let icon: String
        let sunriseTime: Int
        let sunsetTime: Int
        let moonPhase: Double
        let precipIntensity: Float
        let precipIntensityMax: Float
        let precipIntensityMaxTime: Int
        let precipProbability: Double
        let precipType: String?
        let temperatureHigh: Double
        let temperatureHighTime: Int
        let temperatureLow: Double
        let temperatureLowTime: Int
        let dewPoint: Double
        let humidity: Double
        let pressure: Double
        let windSpeed: Double
        let windGust: Double
        let windGustTime: Int
        let windBearing: Int
        let cloudCover: Double
        let uvIndex: Int
        let uvIndexTime: Int
        let visibility: Double
        let ozone: Double
        let temperatureMin: Double
        let temperatureMinTime: Int
        let apparentTemperatureMin: Double
        let apparentTemperatureMinTime: Int
        let apparentTemperatureMax: Double
        let apparentTemperatureMaxTime: Int
    }
    
    struct HourlyWeather: Codable {
        let summary: String
        let icon: String
        let data: [HourlyWeatherEntry]
    }
    
    struct HourlyWeatherEntry: Codable {
        let time: Int
        let summary: String
        let icon: String
        let precipIntensity: Float
        let precipProbability: Double
        let precipType: String?
        let temperature: Double
        let apparentTemperature: Double
        let dewPoint: Double
        let humidity: Double
        let pressure: Double
        let windSpeed: Double
        let windGust: Double
        let windBearing: Int
        let cloudCover: Double
        let uvIndex: Int
        let visibility: Double
        let ozone: Double
    }
    

}

