## load packages
using Random, Distributions
using Plots, ColorSchemes, PlotThemes

## create data
x=collect(-4:0.01:4);
ν=collect(0.5:0.1:5); # letter "nu", not "v"
y=zeros(length(x), length(ν), 2);
for i=1:length(ν)
    y[:, i, 1].=pdf.(TDist(ν[i]), x);
    y[:, i, 2].=cdf.(TDist(ν[i]), x);
end

## animation
theme(:vibrant)
indices = vcat(1:length(ν), reverse(1:length(ν)))
anim = @animate for i=indices
    p1 = plot(
        x, y[:, i, 1],
        lw=3, ylims=(0, 0.6), palette=:RdYlBu_10,
        legend = false,
        xlabel="Sampling space", ylabel="Density",
        title="Student's t(ν) - Probability density"
    )
    annotate!(median(x), 0.6-(0.6/4), text(string.("ν = ", ν[i]), :black, :center, 12))
    annotate!(maximum(x), 0.6-(0.6/20), text("@gongcastro", :black, :right, 6))
    p2 = plot(
        x, y[:, i, 2],
        legend=false, lw=3, ylims=(0, 1), palette=:RdYlBu_10,
        xlabel="Sampling space", ylabel="Probability",
        title="Student's t(ν) - Cumulative distribution"
    )
    plot(p1, p2, size=(1000, 500))
end
gif(anim, "Figures/t-student.gif", fps = 30)
