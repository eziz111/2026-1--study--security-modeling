using Distributions
using Statistics

function simulate_attacks(λ::Float64, T::Float64)

    hourly_counts = rand(Poisson(λ), floor(Int, T))

    intervals = Float64[]
    total_time = 0.0

    while total_time < T
        τ = rand(Exponential(1/λ))
        push!(intervals, τ)
        total_time += τ
    end

    if total_time > T
        pop!(intervals)
    end

    attack_times = cumsum(intervals)

    return (
        hourly_counts = hourly_counts,
        intervals = intervals,
        attack_times = attack_times
    )
end

function simulate_attacks(p::Dict)
    return simulate_attacks(p[:λ], p[:T])
end