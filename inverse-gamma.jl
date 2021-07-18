## load packages
using Random, Distributions
using Plots, ColorSchemes, PlotThemes

## create data
x = collect(0.1:0.01:4);
α = collect(0.1:0.1:5);
θ = collect(0.5:0.1:2);
y = zeros(length(x), length(α), length(θ), 2);
for i = 1:length(α), j = 1:length(θ);
    y[:, i, j, 1] .= pdf.(InverseGamma(α[i], θ[j]), x);
    y[:, i, j, 2] .= cdf.(InverseGamma(α[i], θ[j]), x);
end

## animation
theme(:vibrant)
indices = vcat(1:length(α), reverse(1:length(α)));
anim = @animate for i=indices
    p1 = plot(
        x, y[:, i, :, 1],
        lw=3, ylims=(0, 6), palette=:RdYlBu_10,
        legend=false,
        xlabel="Sampling space", ylabel="Density",
        title="InvGamma(α, θ) - Probability density"
    )
    annotate!(median(x), 6-6/4, text(string.("α = ", α[i]), :black, :center, 12))
    annotate!(maximum(x), 6-6/20, text("@gongcastro", :black, :right, 6))
    p2 = plot(
        x, y[:, i, :, 2],
        legend=:outertopright, label = θ', legendtitle="θ",
        lw=3, ylims=(0, 1), palette=:RdYlBu_10,
        xlabel="Sampling space", ylabel="Probability",
        title="InvGamma(μ, σ) - Cumulative distribution"
    )
    plot(p1, p2, size=(1000, 500))
end
gif(anim, "Figures/inverse-gamma.gif", fps=30)
