using DrWatson
@quickactivate "project"

using Distributions
using Plots
using Statistics

λ_values = [1.0, 3.0, 5.0, 10.0]
k = 10
N = 10000

empirical_probs = Float64[]
theoretical_probs = Float64[]

for λ in λ_values
    sample = rand(Poisson(λ), N)

    emp = count(sample .> k) / N
    theor = 1 - cdf(Poisson(λ), k)

    push!(empirical_probs, emp)
    push!(theoretical_probs, theor)
end

plot(λ_values, empirical_probs,
    marker=:o,
    label="Эмпирическая",
    xlabel="λ",
    ylabel="Вероятность",
    title="Зависимость вероятности от λ")

plot!(λ_values, theoretical_probs,
    marker=:square,
    label="Теоретическая")

savefig(plotsdir("parameter_sweep.png"))