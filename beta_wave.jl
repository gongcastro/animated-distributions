# animate the Beta distribution

# parameter vectors
x = collect(0.01:0.01:0.99); # sampling space
α = collect(0.1:0.1:10);
β = collect(0.1:0.1:10);
# only β=5 is used, but I don't want to mess up the code

# extract probability densities for all combinations of parameters
y = zeros(length(x), length(α), length(β)); # pre-alocate
for i = 1:length(α), j = 1:length(β)
    y[:, i, j] .= pdf.(Beta(α[i], β[j]), x);
end

# plot
indices = vcat(1:length(β), reverse(1:length(β)));
anim = @animate for i = indices
    scatter(
        x, y[:, :, i],
        colorbar=false, fill_z=length(α),
        lw=0, ylims=(0, 6), palette=:RdYlBu_10,
        legend=false,
        showaxis=false,
        xlabel="", ylabel="",
    )
end
gif(anim, "Figures/cover.gif", fps = 30)
