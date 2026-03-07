using DrWatson
@quickactivate "project"

using Plots
using DataFrames

α = 0.3
u0 = 1.0

t = 0:0.1:10

u = u0 .* exp.(α .* t)

plot(t, u,
    label="u(t)",
    xlabel="Время t",
    ylabel="Популяция u",
    title="Аналитическая модель экспоненциального роста",
    lw=2,
    legend=:topleft
)

savefig(plotsdir("analytic_growth.png"))

df = DataFrame(t=t, u=u)

println("Первые 5 строк результатов:")
println(first(df,5))

doubling_time = log(2) / α

println("Аналитическое время удвоения: ",
    round(doubling_time, digits=2))