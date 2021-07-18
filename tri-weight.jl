## load packages
using Random, Distributions
using Plots, ColorSchemes, PlotThemes

## create data
x = collect(-5:0.01:5);
μ = collect(-4:0.5:4);
σ = collect(0.5:0.1:10);
y = zeros(length(x), length(μ), length(σ), 2);
for i = 1:length(μ), j = 1:length(σ)
    y[:, i, j, 1] .= pdf.(Triweight(μ[i], σ[j]), x);
    y[:, i, j, 2] .= cdf.(Triweight(μ[i], σ[j]), x);

end

## animation
theme(:vibrant)
indices = vcat(1:length(σ), reverse(1:length(σ)));
anim = @animate for i=indices
    p1 = plot(
        x, y[:, :, i, 1],
        lw=3, ylims=(0, 2), palette=:RdYlBu_10,
        legend=false,
        xlabel="Sampling space", ylabel="Density",
        title="Tri-weight(μ, σ) - Probability density"
    )
    annotate!(median(x), 2-2/4, text(string.("σ = ", σ[i]), :black, :center, 12))
    annotate!(maximum(x), 2-2/20, text("@gongcastro", :black, :right, 6))
    p2 = plot(
        x, y[:, :, i, 2],
        legend=:outertopright, label = μ', legendtitle="μ",
        lw=3, ylims=(0, 1), palette=:RdYlBu_10,
        xlabel="Sampling space", ylabel="Probability",
        title="Tri-weight(μ, σ) - Cumulative distribution"
    )
    plot(p1, p2, size=(1000, 500))
end
gif(anim, "Figures/triweight.gif", fps=30)
