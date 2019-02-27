//
//  ViewController.swift
//  SeattleWeather
//
//  Created by Shouting Lyu on 2/26/19.
//  Copyright © 2019 Shouting Lyu. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityProtocol{
    

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWeatherCondition: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    
    let locationManager = CLLocationManager()
    let API_ROOT = "http://api.openweathermap.org/data/2.5/weather"
    let API_KEY = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    // Inplement Protocol to Change City
    func ChangeCityFunction(cityName: String) {
        print("User select another city\(cityName)")
    }
    
    @IBAction func changeCity(_ sender: UIButton) {
        performSegue(withIdentifier: "changeCitySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let changeCityController = segue.destination as! ChangeCityViewController
        changeCityController.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            print("lat is \(lat) lon is \(lon)")
            let params: [String: String] = [
                "lat": lat,
                "lon": lon,
                "appid": API_KEY
            ]
            getWeatherData(url: API_ROOT, params: params)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.lblCityName.text = "--"
        self.lblTemperature.text = "--"
        self.lblWeatherCondition.text = "No Location Detected"
    }

    func getWeatherData(url: String, params: [String: String]) {
        Alamofire.request(url,  method: .get, parameters: params).responseJSON{
            response in
            if response.result.isSuccess {
                print("Successfully get data")
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
            } else {
                print("Fail to get data")
                let jsonError = String(describing: response.result.error)
                print(jsonError)
                
                self.lblCityName.text = "--"
                self.lblTemperature.text = "--"
                self.lblWeatherCondition.text = "Network Error"
            }
        }
    }
}

