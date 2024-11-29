

# WeatherApp

WeatherApp — это iOS-приложение, предоставляющее текущую погоду в реальном времени с использованием данных OpenWeather API. 

## 📱 Функциональные возможности

- Отображение текущей температуры, максимальной/минимальной температуры, влажности, давления, скорости ветра и видимости.
- Асинхронная загрузка данных с использованием Alamofire.
- Интуитивно понятный интерфейс с адаптивным дизайном.
- Локализация погоды на основе текущего местоположения.
- Кэширование изображений с помощью PinLayout.

---

## 🛠️ Стек технологий

- **Язык**: Swift
- **Сетевые запросы**: [Alamofire](https://github.com/Alamofire/Alamofire)
- **UI**: UIKit
- **Данные о погоде**: [OpenWeather API](https://openweathermap.org/api)
- **Определение местоположения**: CoreLocation
- **Архитектура**: MVC (Model-View-Controller)

---

## 🔧 Установка

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/ваш_репозиторий.git
   ```

2. Установите зависимости с помощью CocoaPods или Swift Package Manager:
   ```bash
   pod install
   ```

3. Откройте `WeatherApp.xcworkspace` в Xcode.

4. Добавьте API-ключ OpenWeather в `ApiRouter.swift`:
   ```swift
   "appid": "ВАШ_API_КЛЮЧ"
   ```

5. Запустите приложение на симуляторе или реальном устройстве.

---

## 📂 Структура проекта

- **Models**: Классы для представления данных (например, `WeatherModel`).
- **ViewModels**: Логика работы с данными и их подготовки для отображения (например, `CurrentWeatherViewModel`).
- **Views**: Пользовательский интерфейс (например, кастомные ячейки `MainDataTableViewCell`, `InfoDataTableViewCell`).
- **Networking**: Работа с API (например, `ApiRouter`, `APIClient`).
- **Extensions**: Полезные расширения (например, для `Date`).

