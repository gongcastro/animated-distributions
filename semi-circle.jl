## load packages
using Random, Distributions
using Plots, ColorSchemes, PlotThemes

## create data
x=collect(-10:0.05:10);
R=collect(0.1:0.1:10);
y=zeros(length(x), length(R), 2);
for i=1:length(R)
    y[:, i, 1].=pdf.(Semicircle(R[i]), x);
    y[:, i, 2].=cdf.(Semicircle(R[i]), x);
end

## animation
theme(:vibrant)
indices = vcat(1:length(R), reverse(1:length(R)));
anim = @animate for i=indices
    p1 = plot(
        x, y[:, i, 1],
        lw=3, ylims=(0, 3), palette=:RdYlBu_10,
        legend = false,
        xlabel="Sampling space", ylabel="Density",
        title="Semi-circle(R) - Probability density"
    )
    annotate!(median(x), 3-3/4, text(string.("R = ", R[i]), :black, :center, 12))
    annotate!(maximum(x), 3-3/20, text("@gongcastro", :black, :right, 6))
    p2 = plot(
        x, y[:, i, 2],
        legend=false, lw=3, ylims=(0, 1), palette=:RdYlBu_10,
        xlabel="Sampling space", ylabel="Probability",
        title="Semi-circle(R) - Cumulative distribution"
    )
    plot(p1, p2, size=(1000, 500))
end
gif(anim, "Figures/semicircle.gif", fps=30)
