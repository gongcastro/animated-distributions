## load packages
using Random, Distributions, LaTeXStrings
using Plots, ColorSchemes, PlotThemes

## create data
x = collect(0.01:0.01:0.99);
α = collect(0.1:0.1:10);
β = collect(0.1:1:10);
y = zeros(length(x), length(α), length(β));
for i = 1:length(α), j = 1:length(β)
    y[:, i, j] .= pdf.(Beta(α[i], β[j]), x);
end

plot(
    x, y[:, 1, :],
    legend=:outertopright, label = β', legendtitle="β",
    lw=3, ylims=(0, 1), palette=:RdYlBu_10,
    xlabel="Sampling space", ylabel="Probability",
    title="Beta(α, β) - Cumulative distribution"
)
annotate!(0.5, 0.5, text(string.("α = ", α[1]), :black, :center, 12))
annotate!(
    0.5, 0.9,
    text(
        string.(L"\frac{x^{\alpha=", α[1], L"-1}(1-x)^{\beta-1}}{\frac{\Gamma(\alpha)\Gamma(\beta)}{\Gamma(\alpha+\beta)}}"),
        :black, :center, 12
    )
)
