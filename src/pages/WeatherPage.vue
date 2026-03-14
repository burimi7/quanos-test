<template>
  <q-layout view="lHh Lpr lFf">
    <div class="q-pa-md">
      <!-- Add input field for city name -->
      <div class="row items-center q-gutter-md">
        <!-- Search input - primary action, takes most space -->
        <q-input
          v-model="cityName"
          class="col"
          label="Enter city name"
          outlined
          dense
          autofocus
          placeholder="e.g., London, Tokyo, New York"
          @keyup.enter="getCoordinatesFromCityName"
        >
          <template v-slot:prepend>
            <q-icon name="search" />
          </template>
        </q-input>

        <!-- Unit toggle - secondary preference, stays compact -->
        <q-btn-toggle
          v-model="unitSystem"
          no-caps
          rounded
          unelevated
          toggle-color="primary"
          color="white"
          text-color="primary"
          :options="[
            { label: 'Metric', value: 'metric' },
            { label: 'Imperial', value: 'imperial' },
          ]"
          class="q-mx-sm"
          @update:model-value="onUnitChange"
        />

        <!-- Action button - final confirmation -->
        <q-btn
          @click="getCoordinatesFromCityName"
          color="primary"
          :loading="isLoading"
          :disable="!cityName.trim()"
          label="Get weather"
          icon="cloud"
          no-caps
          unelevated
        />
      </div>

      <!-- Display results -->
      <!-- <div v-if="coordinates" class="q-mt-md">
        <q-card>
          <q-card-section>
            <div><strong>Latitude:</strong> {{ coordinates.lat }}</div>
            <div><strong>Longitude:</strong> {{ coordinates.lon }}</div>
            <div><strong>Country:</strong> {{ coordinates.country }}</div>
            <div v-if="coordinates.name"><strong>Name:</strong> {{ coordinates.name }}</div>
          </q-card-section>
        </q-card>
      </div> -->

      <!-- Show error message -->
      <div v-if="error" class="text-negative q-mt-md">
        {{ error }}
      </div>
      <div class="weather-display q-pa-md">
        <!-- Current Weather Card -->
        <q-card class="weather-card q-mb-md" flat bordered>
          <q-card-section class="bg-primary text-white">
            <div class="row items-center no-wrap">
              <div class="col">
                <div class="text-h6">Current Weather</div>
              </div>
              <div class="col-auto">
                <q-chip size="md" square class="bg-white text-primary">
                  {{ weather?.main?.temp }}°{{ tempUnit() }}
                </q-chip>
              </div>
            </div>
          </q-card-section>

          <q-card-section>
            <!-- Main Weather Info -->
            <div class="row q-col-gutter-md">
              <!-- Weather Icon and Description -->
              <div class="col-12 col-sm-6">
                <div class="row items-center">
                  <div class="col-auto">
                    <q-icon
                      :name="`img:https://openweathermap.org/img/wn/${weather?.weather?.[0]?.icon}@2x.png`"
                      size="80px"
                    />
                  </div>
                  <div class="col">
                    <div class="text-h4 text-weight-bold">
                      {{ weather?.weather?.[0]?.main }}
                    </div>
                    <div class="text-subtitle1 text-grey-7">
                      {{ weather?.weather?.[0]?.description }}
                    </div>
                  </div>
                </div>
              </div>

              <!-- Temperature Details -->
              <div class="col-12 col-sm-6">
                <div class="row q-col-gutter-sm">
                  <div class="col-6">
                    <q-item dense>
                      <q-item-section avatar>
                        <q-icon name="thermostat" color="primary" size="sm" />
                      </q-item-section>
                      <q-item-section>
                        <q-item-label caption>Feels Like</q-item-label>
                        <q-item-label class="text-weight-bold"
                          >{{ weather?.main?.feels_like }}°{{ tempUnit() }}</q-item-label
                        >
                      </q-item-section>
                    </q-item>
                  </div>
                  <div class="col-6">
                    <q-item dense>
                      <q-item-section avatar>
                        <q-icon name="arrow_upward" color="primary" size="sm" />
                      </q-item-section>
                      <q-item-section>
                        <q-item-label caption>Max</q-item-label>
                        <q-item-label class="text-weight-bold"
                          >{{ weather?.main?.temp_max }}°{{ tempUnit() }}</q-item-label
                        >
                      </q-item-section>
                    </q-item>
                  </div>
                  <div class="col-6">
                    <q-item dense>
                      <q-item-section avatar>
                        <q-icon name="arrow_downward" color="primary" size="sm" />
                      </q-item-section>
                      <q-item-section>
                        <q-item-label caption>Min</q-item-label>
                        <q-item-label class="text-weight-bold"
                          >{{ weather?.main?.temp_min }}°{{ tempUnit() }}</q-item-label
                        >
                      </q-item-section>
                    </q-item>
                  </div>
                </div>
              </div>
            </div>

            <!-- Additional Metrics Grid -->
            <div class="row q-col-gutter-sm q-mt-md">
              <!-- Humidity -->
              <div class="col-6 col-sm-3">
                <q-card flat bordered class="metric-card">
                  <q-card-section class="text-center">
                    <q-icon name="water_drop" color="primary" size="28px" />
                    <div class="text-h6 q-mt-xs">{{ weather?.main?.humidity }}%</div>
                    <div class="text-caption text-grey-7">Humidity</div>
                  </q-card-section>
                </q-card>
              </div>

              <!-- Pressure -->
              <div class="col-6 col-sm-3">
                <q-card flat bordered class="metric-card">
                  <q-card-section class="text-center">
                    <q-icon name="compress" color="primary" size="28px" />
                    <div class="text-h6 q-mt-xs">{{ weather?.main?.pressure }} hPa</div>
                    <div class="text-caption text-grey-7">Pressure</div>
                  </q-card-section>
                </q-card>
              </div>

              <!-- Visibility -->
              <div class="col-6 col-sm-3">
                <q-card flat bordered class="metric-card">
                  <q-card-section class="text-center">
                    <q-icon name="visibility" color="primary" size="28px" />
                    <div class="text-h6 q-mt-xs">
                      {{ formatVisibility(weather?.visibility || 0) }}
                    </div>
                    <div class="text-caption text-grey-7">Visibility</div>
                  </q-card-section>
                </q-card>
              </div>

              <!-- Wind Speed -->
              <div class="col-6 col-sm-3">
                <q-card flat bordered class="metric-card">
                  <q-card-section class="text-center">
                    <q-icon name="air" color="primary" size="28px" />
                    <div class="text-h6 q-mt-xs">
                      {{ weather?.wind?.speed }} {{ windUnit() }} AAA
                    </div>
                    <div class="text-caption text-grey-7">Wind Speed</div>
                  </q-card-section>
                </q-card>
              </div>
            </div>

            <!-- Wind Details -->
            <div class="row q-mt-md">
              <div class="col-12">
                <q-card flat bordered>
                  <q-card-section>
                    <div class="text-subtitle2 q-mb-sm">Wind Details</div>
                    <div class="row q-col-gutter-md">
                      <div class="col-4 text-center">
                        <div class="text-grey-7">Direction</div>
                        <div class="text-h6">{{ weather?.wind?.deg }}°</div>
                      </div>
                      <div class="col-4 text-center">
                        <div class="text-grey-7">Speed</div>
                        <div class="text-h6">{{ weather?.wind?.speed }} {{ windUnit() }}</div>
                      </div>
                      <div class="col-4 text-center" v-if="weather?.wind?.gust">
                        <div class="text-grey-7">Gust</div>
                        <div class="text-h6">{{ weather?.wind?.gust }} {{ windUnit() }}</div>
                      </div>
                    </div>
                  </q-card-section>
                </q-card>
              </div>
            </div>
          </q-card-section>
        </q-card>
      </div>
    </div>
  </q-layout>
</template>

<script setup lang="ts">
import type { WeatherData } from 'src/interfaces/weatherData';
import { ref } from 'vue';

// Temperature unit
const tempUnit = () => {
  return unitSystem.value === 'metric' ? 'C' : 'F';
};

// Wind unit
const windUnit = () => {
  return unitSystem.value === 'metric' ? 'm/s' : 'mph';
};

// Format visibility based on unit system
const formatVisibility = (visibilityInMeters: number) => {
  if (!visibilityInMeters) return 'N/A';

  if (unitSystem.value === 'metric') {
    // Metric: show in kilometers
    return `${(visibilityInMeters / 1000).toFixed(1)} km`;
  } else {
    // Imperial: convert meters to miles (1 meter = 0.000621371 miles)
    const miles = visibilityInMeters * 0.000621371;
    return `${miles.toFixed(1)} mi`;
  }
};

const VITE_API_URL = import.meta.env.VITE_API_URL;
const API_KEY = import.meta.env.VITE_API_KEY;

// Reactive state
const isLoading = ref(false);
const cityName = ref('');
const weather = ref<WeatherData | null>(null);
const unitSystem = ref('metric'); // Default to metric
const coordinates = ref<null | { lat: number; lon: number; name?: string; country?: string }>(null);
const error = ref<string | null>(null);
const emit = defineEmits(['unit-change']);

// Emit when unit changes
const onUnitChange = async (value: Event) => {
  emit('unit-change', value);
  if (weather.value !== null) await getCoordinatesFromCityName();
};

const getCoordinatesFromCityName = async () => {
  // Clear previous results/errors
  coordinates.value = null;
  error.value = null;

  // Validate input
  const trimmedCity = cityName.value.trim();
  if (trimmedCity === '') {
    error.value = 'Please enter a city name';
    return;
  }

  isLoading.value = true;

  // Properly encode the city name for URL
  const encodedCityName = encodeURIComponent(trimmedCity);
  //   const apiUrl = `${VITE_API_URL}${encodedCityName},${stateCode.value},${countryCode.value}&limit=1&appid=${API_KEY}`;
  const apiUrl = `${VITE_API_URL}${encodedCityName}&appid=${API_KEY}&units=${unitSystem.value}`;
  try {
    const response = await fetch(apiUrl);
    if (!response.ok) {
      throw new Error(`Failed to fetch: ${response.status} ${response.statusText}`);
    }

    const data = await response.json();
    weather.value = data;
    // Check if any results were returned
    if (!data || data.length === 0) {
      throw new Error('City not found');
    }
  } catch (err) {
    error.value = err instanceof Error ? err.message : 'An unknown error occurred';
    console.error('Error fetching coordinates:', err);
  } finally {
    isLoading.value = false;
  }
};
</script>
