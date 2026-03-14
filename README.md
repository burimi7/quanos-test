🌤️ Weather App - Vue 3 + Quasar
A weather application built with Vue 3, Quasar Framework, and OpenWeatherMap API. Search for any city and get real-time weather information with a clean, responsive interface.

📋 Table of Contents
Features

Demo

Prerequisites

Installation

Configuration

Running the App

Usage

Technologies Used

API Reference

Project Structure

Contributing

License

✨ Features
🔍 City Search - Search for weather in any city worldwide

🌡️ Current Weather - Temperature, feels like, min/max, humidity, pressure, visibility

💨 Wind Information - Wind speed, direction, and gusts

🔄 Unit Toggle - Switch between Metric (°C, m/s, km) and Imperial (°F, mph, mi)

📱 Responsive Design - Works perfectly on desktop, tablet, and mobile

⚡ Fast & Reactive - Built with Vue 3 Composition API

🎯 TypeScript - Full type safety with TypeScript

🚀 Prerequisites
Before you begin, ensure you have installed:

Node.js (v18 or higher) - Download

npm or yarn or pnpm (comes with Node.js)

Git - Download

📦 Installation
Clone the repository

bash
git clone https://github.com/yourusername/quanos-test.git
cd quanos-test
Install dependencies

bash
npm install

# or

yarn install

# or

pnpm install
🔧 Configuration
Get an API Key from OpenWeatherMap

Visit OpenWeatherMap

Sign up for a free account

Go to your dashboard and copy your API key

Create environment file
Create a .env file in the root directory:

bash
VITE_API_KEY=your_openweathermap_api_key_here
VITE_API_GEO_URL=http://api.openweathermap.org/geo/1.0/direct
VITE_API_WEATHER_URL=https://api.openweathermap.org/data/2.5/weather
Note: Replace your_openweathermap_api_key_here with your actual API key

🏃 Running the App
Development Mode
bash
npm run dev

# or

quasar dev
The app will open at http://localhost:9000

Production Build
bash
npm run build

# or

quasar build
Lint Code
bash
npm run lint
🎮 Usage
Search for a city

Type a city name in the search box (e.g., "London", "Tokyo", "New York")

Press Enter or click the "Get weather" button

Toggle units

Use the °C/°F toggle switch to change between Metric and Imperial units

Temperature, wind speed, and visibility units will update automatically

View weather information

Current temperature and conditions

Feels like temperature

Min/Max temperature

Humidity percentage

Atmospheric pressure (hPa)

Visibility distance

Wind speed, direction, and gusts

🛠️ Technologies Used
Vue 3 - Progressive JavaScript framework

Quasar Framework - Vue-based UI framework

TypeScript - Type safety

Vite - Build tool and dev server

OpenWeatherMap API - Weather data

ESLint - Code linting

📡 API Reference
The app uses the following OpenWeatherMap endpoints:

Endpoint Purpose Free Tier Limits
https://api.openweathermap.org/data/2.5/weather Get current weather data 60 calls/minute
API Parameters:

q: City name (e.g., "London")

appid: Your API key

units: metric (Celsius) or imperial (Fahrenheit)

limit: Number of results (for geocoding)

📁 Project Structure
text
quanos-test/
├── public/ # Static assets
├── src/
│ ├── assets/ # Images, styles
│ ├── components/ # Vue components
│ │ ├── WeatherDisplay.vue
│ │ └── UnitToggle.vue
│ ├── pages/ # Page components
│ │ └── WeatherPage.vue
│ ├── interfaces/ # TypeScript interfaces
│ │ └── weatherData.ts
│ ├── App.vue # Root component
│ └── main.js # Entry point
├── .env # Environment variables
├── .eslintrc.js # ESLint configuration
├── index.html # HTML template
├── package.json # Dependencies
├── quasar.config.js # Quasar configuration
└── README.md # This file

📧 Contact
Burim Ismaili - ismailiburim88@gmail.com

Project Link: https://github.com/yourusername/quanos-test
