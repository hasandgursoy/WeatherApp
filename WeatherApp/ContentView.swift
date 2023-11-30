//
//  ContentView.swift
//  WeatherApp
//
//  Created by Hasan Doğacan Gürsoy on 29.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    // State Durumu takip etmek için , Binding Objenin değişip değişmeyeceğine müdahele etmek için
    @State private var isNight = false
    
    private var weatherDays : [WeatherDay] = [
        WeatherDay(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temparature: 74),
        WeatherDay(dayOfWeek: "WED", imageName: "sun.max.fill", temparature: 72),
        WeatherDay(dayOfWeek: "THU", imageName: "wind.snow", temparature: 78),
        WeatherDay(dayOfWeek: "FRI", imageName: "cloud.drizzle.fill", temparature: 65),
        WeatherDay(dayOfWeek: "SAT", imageName: "cloud.snow.fill", temparature: 20)
        
    ]
    
    var body: some View {
        ZStack {
            BackGroundView(isNight: isNight)
            VStack{
                CityTextView(cityName: "Cupertino, CA")
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill": "cloud.sun.fill", temperature: isNight ? 40 : 76 )
                
                HStack(spacing:20){
                        ForEach(weatherDays){ day in
                            WeatherDayView(
                                dayOfWeek: day.dayOfWeek,
                                imageName: day.imageName,
                                temprature:day.temparature)
                        }
                }
                Spacer()
                Button{
                    isNight.toggle()
                }label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgorundColor: .white)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temprature: Int
    
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16,weight: .medium))
                .foregroundColor(.white)
            Image(systemName:imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width: 40,height: 40)
            Text("\(temprature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackGroundView: View {
    
    var isNight : Bool

    
    var body: some View {
        
//        LinearGradient(gradient: Gradient(
//            colors: [isNight ? .black : .blue, isNight ? .gray : .white,]),
//                       startPoint: .topLeading,
//                       endPoint: .bottomTrailing)
//        .ignoresSafeArea()
        ContainerRelativeShape()
            .fill( isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}

struct CityTextView : View{
    
    var cityName : String
    
    var body: some View{
        Text("Cupertino, CA")
            .font(.system(size: 32,weight:.medium,design: .default))
            .foregroundColor(Color.white)
            .padding(.bottom)
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10){
            Image(systemName:imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width: 180,height: 180)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }.padding(.bottom,40)
    }
}

struct WeatherDay : Identifiable{
    var id : UUID = UUID()
    var dayOfWeek : String
    var imageName : String
    var temparature : Int
    
    init(dayOfWeek: String, imageName: String, temparature: Int) {
        self.dayOfWeek = dayOfWeek
        self.imageName = imageName
        self.temparature = temparature
    }
}
