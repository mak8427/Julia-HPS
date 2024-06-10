using SpeedyWeather
spectral_grid = SpectralGrid(trunc=127, nlev=1)

# model components
time_stepping = SpeedyWeather.Leapfrog(spectral_grid, Δt_at_T31=Minute(30))
implicit = SpeedyWeather.ImplicitShallowWater(spectral_grid, α=0.5)
orography = EarthOrography(spectral_grid, smoothing=false)
initial_conditions = SpeedyWeather.RandomWaves()

# construct, initialize, run
model = ShallowWaterModel(; spectral_grid, orography, initial_conditions, implicit, time_stepping)
simulation = initialize!(model)
run!(simulation, period=Day(2))

