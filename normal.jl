## load packages
using Random, Distributions
using Plots, ColorSchemes, PlotThemes

## create data
x = collect(-4:0.01:4);
μ = collect(-4:0.5:4);
σ = collect(1:0.1:8);
y = zeros(length(x), length(μ), length(σ), 2);
for i = 1:length(μ), j = 1:length(σ)
    y[:, i, j, 1] .= pdf.(Normal(μ[i], σ[j]), x);
    y[:, i, j, 2] .= cdf.(Normal(μ[i], σ[j]), x);
end

## animation
theme(:vibrant)
indices = vcat(1:length(σ), reverse(1:length(σ)));
anim = @animate for i=indices
    p1 = plot(
        x, y[:, :, i, 1],
        lw=3, ylims=(0, 0.4), palette=:RdYlBu_10,
        legend=false,
        xlabel="Sampling space", ylabel="Density",
        title="Normal(μ, σ) - Probability density"
    )
    annotate!(median(x), 0.4-0.4/4, text(string.("σ = ", σ[i]), :black, :center, 12))
    annotate!(maximum(x), 0.4-0.4/20, text("@gongcastro", :black, :right, 6))
    p2 = plot(
        x, y[:, :, i, 2],
        legend=:outertopright, label = μ', legendtitle="μ",
        lw=3, ylims=(0, 1), palette=:RdYlBu_10,
        xlabel="Sampling space", ylabel="Probability",
        title="Normal(μ, σ) - Cumulative distribution"
    )
    plot(p1, p2, size=(1000, 500))
end
gif(anim, "Figures/normal.gif", fps=30)
