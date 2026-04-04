using DrWatson
@quickactivate "project"

using Distributions
using Plots
using Statistics

λ = 5.0
k = 10

Ns = [10, 50, 100, 500, 1000, 5000]
estimates = Float64[]

for N in Ns
    sample = rand(Poisson(λ), N)
    prob = count(sample .> k) / N
    push!(estimates, prob)
end

theoretical = 1 - cdf(Poisson(λ), k)

plot(Ns, estimates,
    marker=:o,
    label="Эмпирическая",
    xlabel="Размер выборки",
    ylabel="Вероятность",
    title="Сходимость оценки")

hline!([theoretical],
    linestyle=:dash,
    label="Теоретическая")

savefig(plotsdir("convergence.png"))