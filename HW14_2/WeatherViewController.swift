//
//  WeatherViewController.swift
//  HW14_2
//
//  Created by MaximRezvanov on 3/13/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import Foundation
import CoreData



class WeatherViewController: UIViewController {
        
    @IBOutlet weak var currentWeatherOutlet: UIButton!
    @IBOutlet weak var forecastWeatherOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!

    
    
    @IBAction func currentWeatherAction(_ sender: Any) {
        fetchData()
        test = true
        self.tableView.reloadData()
    }
    
    @IBAction func forecastWeatherAction(_ sender: Any) {
        createWeatherForecast()
        test = false
        self.tableView.reloadData()
    }
    
    
    var weatherData = DataWeather()
    var test = false
    var ViewC = ViewCell.description()
    
    
    private var forecastWeather = MainWeatherModel(){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
  
    func fetchData () {
        
        let urlSting = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&lang=ru&appid=45b2ba58094596043830cb6caaf2df46"
        guard let url = URL(string: urlSting) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do{
                self.weatherData = try JSONDecoder().decode(DataWeather.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    func createWeatherForecast() {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&units=metric&lang=ru&APPID=45b2ba58094596043830cb6caaf2df46") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do{
                self.forecastWeather = try JSONDecoder().decode(MainWeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print (error)
                
            }
        }.resume()
        
    }
    
    private func confingureCell (cell: ViewCell, for indexPath: IndexPath) {
        cell.cityNameLabel.text = self.weatherData.name
        cell.descriptionLabel.text = self.weatherData.weather?[indexPath.row].description
        cell.temperatureLabel.text = self.weatherData.main.temp!.description + "°"
        cell.tempMaxLabel.text = self.weatherData.main.temp_max!.description + "°"
        cell.tempMinLabel.text = self.weatherData.main.temp_min!.description + "°"
        
        // сохранение в модель
        DataStorage.shared.cityName = cell.cityNameLabel.text
        DataStorage.shared.description = cell.descriptionLabel.text
        DataStorage.shared.temperature = NSString(string: cell.temperatureLabel.text!).doubleValue
        DataStorage.shared.tempMax = NSString(string: cell.tempMinLabel.text!).doubleValue
        DataStorage.shared.tempMin = NSString(string: cell.tempMaxLabel.text!).doubleValue
    }
    
    
    private func configureCellForecast(cell: ViewCell, for indexPath: IndexPath) {
        cell.cityNameLabel.text = self.forecastWeather.city?.name
        cell.dtLabel.text = self.forecastWeather.list?[indexPath.row].dt_txt
        cell.descriptionLabel.text = forecastWeather.list?[indexPath.row].weather?[0].description
        cell.temperatureLabel.text = self.forecastWeather.list?[indexPath.row].main?.temp?.description
        cell.tempMinLabel.text = self.forecastWeather.list?[indexPath.row].main?.temp_min?.description
        cell.tempMaxLabel.text = self.forecastWeather.list?[indexPath.row].main?.temp_max?.description
    }
    
   
}

extension WeatherViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if test{
            return weatherData.weather?.count ?? 0
        } else {
            
            return self.forecastWeather.list?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3") as! ViewCell
        cell.cityNameLabel.text = DataStorage.shared.cityName
        cell.descriptionLabel.text = DataStorage.shared.description
        cell.temperatureLabel.text = "\(String(describing: DataStorage.shared.temperature!))"
        cell.tempMinLabel.text = "\(String(describing: DataStorage.shared.tempMin!))"
        cell.tempMaxLabel.text = "\(String(describing: DataStorage.shared.tempMax!))"
        if test {
            confingureCell(cell: cell, for: indexPath)
            
            
        } else {
            configureCellForecast(cell: cell, for: indexPath)
        }
        return cell
    }
}
