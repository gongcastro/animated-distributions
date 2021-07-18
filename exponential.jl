## load packages
using Random, Distributions
using Plots, ColorSchemes, PlotThemes

## create data
x=collect(0:0.01:10);
θ=collect(0.5:0.1:8);
y=zeros(length(x), length(θ), 2);
for i=1:length(θ)
    y[:, i, 1].=pdf.(Exponential(θ[i]), x);
    y[:, i, 2].=cdf.(Exponential(θ[i]), x);
end

## animation
theme(:vibrant)
indices = vcat(1:length(θ), reverse(1:length(θ)));
anim = @animate for i=indices
    p1 = plot(
        x, y[:, i, 1],
        lw=3, ylims=(0, 3), palette=:RdYlBu_10,
        legend = false,
        xlabel="Sampling space", ylabel="Density",
        title="Exp(θ) - Probability density"
    )
    annotate!(median(x), 3-3/4, text(string.("θ = ", θ[i]), :black, :center, 12))
    annotate!(maximum(x), 3-3/20, text("@gongcastro", :black, :right, 6))
    p2 = plot(
        x, y[:, i, 2],
        legend=false, lw=3, ylims=(0, 1), palette=:RdYlBu_10,
        xlabel="Sampling space", ylabel="Probability",
        title="Exp(θ) - Cumulative distribution"
    )
    plot(p1, p2, size=(1000, 500))
end
gif(anim, "Figures/exponential.gif", fps=30)
