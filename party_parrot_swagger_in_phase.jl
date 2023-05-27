using Colors, Plots

# Define the parrot colors
parrot_colors = [RGB(255/255, 75/255, 0/255), RGB(255/255, 200/255, 0/255),
                 RGB(90/255, 255/255, 90/255), RGB(0/255, 255/255, 255/255),
                 RGB(0/255, 160/255, 255/255), RGB(90/255, 0/255, 255/255),
                 RGB(175/255, 0/255, 255/255), RGB(255/255, 0/255, 200/255),
                 RGB(255/255, 0/255, 125/255), RGB(255/255, 0/255, 0/255)]

# Functions for creating tints and shades
function shade(color::RGB, factor::Float64)
    r = red(color) * (1 - factor)
    g = green(color) * (1 - factor)
    b = blue(color) * (1 - factor)
    return RGB(r, g, b)
end

function tint(color::RGB, factor::Float64)
    r = red(color) + (1 - red(color)) * factor
    g = green(color) + (1 - green(color)) * factor
    b = blue(color) + (1 - blue(color)) * factor
    return RGB(r, g, b)
end

# Create tints and shades
tints_and_shades = []
for color in parrot_colors
    push!(tints_and_shades, shade(color, 0.3)) # shade
    push!(tints_and_shades, color) # original color
    push!(tints_and_shades, tint(color, 0.3)) # tint
end

# Define base positions for the orbs
x_base = [0, sqrt(3)/2, -sqrt(3)/2]
y_base = [1, -0.5, -0.5]

# Define the amplitude and frequency for the elliptical motion
amp = 0.2
freq = 3 * 2π / length(tints_and_shades)

# Create the animation
anim = @animate for i in 1:length(tints_and_shades)
    p = plot(size=(500,500), xlim=(-2,2), ylim=(-2,2), aspect_ratio=:equal, showaxis=false)
    
    for j in 1:3
        x = x_base[j] + amp * cos(freq * i)
        y = y_base[j] + amp * sin(freq * i)
        color = tints_and_shades[mod1(i+j-1, length(tints_and_shades))]
        scatter!([x], [y], markersize=80, color=color, label=false)
    end
end

# Save the animation as a gif
gif(anim, "parrot_julia_swagger_in_phase.gif", fps = 15)

