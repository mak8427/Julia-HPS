using CairoMakie

u, v, w = model.velocities
ζ = Field(∂x(v) - ∂y(u))
compute!(ζ)

heatmap(interior(ζ, :, :, 1))

using Oceananigans

grid = RectilinearGrid(size=(128, 128), x=(0, 2π), y=(0, 2π), topology=(Periodic, Periodic, Flat))
model = NonhydrostaticModel(; grid, advection=WENO())

ϵ(x, y) = 2rand() - 1
set!(model, u=ϵ, v=ϵ)

simulation = Simulation(model; Δt=0.01, stop_iteration=100)
run!(simulation)

simulation.stop_iteration += 400
run!(simulation)

compute!(ζ)
heatmap(interior(ζ, :, :, 1))