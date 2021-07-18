## load packages
using Random, Distributions
using Plots, ColorSchemes, PlotThemes

## create data
x = collect(0:0.01:5);
σ = collect(0.1:0.1:5);
y = zeros(length(x), length(σ), 2);
for i = 1:length(σ)
    y[:, i, 1] .= pdf.(Rayleigh(σ[i]), x);
    y[:, i, 2] .= cdf.(Rayleigh(σ[i]), x);
end


## animation
theme(:vibrant)
indices = vcat(1:length(σ), reverse(1:length(σ)));
anim = @animate for i=indices
    p1 = plot(
        x, y[:, i, 1],
        lw=3, ylims=(0, 3), palette=:RdYlBu_10,
        legend = false,
        xlabel="Sampling space", ylabel="Density",
        title="Rayleigh(σ) - Probability density"
    )
    annotate!(2.5, 2.5, text(string.("σ = ", σ[i]), :black, :center, 12))
    p2 = plot(
        x, y[:, i, 2],
        legend=false, lw=3, ylims=(0, 1), palette=:RdYlBu_10,
        xlabel="Sampling space", ylabel="Probability",
        title="Rayleigh(σ) - Cumulative distribution"
    )
    plot(p1, p2, size=(1000, 500))
end
gif(anim, "Figures/rayleigh.gif", fps=30)
