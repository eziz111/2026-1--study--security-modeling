using DrWatson
@quickactivate "project"

using JLD2
using Plots
using StatsPlots
using Distributions

# загружаем данные
files = readdir(datadir("attack_sim"))
filename = joinpath(datadir("attack_sim"), files[1])
data = load(filename)["data"]

hourly_counts = data[:hourly_counts]
intervals = data[:intervals]
attack_times = data[:attack_times]

# 1. Гистограмма распределения (Пуассон)
p1 = histogram(hourly_counts,
    normalize=true,
    bins=20,
    title="Распределение числа атак",
    label="Эмпирическое")

λ = mean(hourly_counts)
x = 0:maximum(hourly_counts)
plot!(p1, x, pdf.(Poisson(λ), x),
    label="Пуассон",
    lw=2)

# 2. Накопление атак
p2 = plot(attack_times,
    1:length(attack_times),
    xlabel="Время",
    ylabel="Количество атак",
    title="Накопление атак",
    label="")

# 3. Интервалы (экспоненциальное распределение)
p3 = histogram(intervals,
    normalize=true,
    bins=20,
    title="Интервалы между атаками",
    label="Эмпирическое")

plot!(p3,
    x -> pdf(Exponential(1/λ), x),
    0,
    maximum(intervals),
    label="Экспоненциальное",
    lw=2)

# 4. QQ plot
p4 = qqplot(Exponential(1/λ), intervals,
    title="QQ plot")

# объединение графиков
plot(p1, p2, p3, p4, layout=(2,2))

savefig(plotsdir("attack_sim_plots.png"))