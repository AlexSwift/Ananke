Ananke.mathsx.perlin = {}

mathsx.perlin = {}

mathsx.perlin.octaves = 2
mathsx.perlin.persistence = .01
mathsx.perlin.noised = {}
 
function mathsx.perlin.cos_interpolate(a, b, x)
        local ft = x * math.pi
        local f = (1 - math.cos(ft)) * .5
 
        return  a * (1 - f) + b * f
end
 
function mathsx.perlin.noise_2d(x, y, i, seed)
        local nx = mathsx.perlin.noised[x]
 
        if (nx and nx[y]) then
                return nx[y]
        else
                nx = nx or {}
                math.randomseed((x * seed + y * i ^ 1.1 + 14) / 789221 + 33 * x + 15731 * y * seed)
        end
 
        math.random()
 
        mathsx.perlin.noised[x] = nx
        nx[y] = math.random(-1000, 1000) / 1000
 
        return nx[y]
end
 
function mathsx.perlin.smooth_noise_2d(x, y, i, seed)
        local corners = (mathsx.perlin.noise_2d(x - 1, y - 1, i, seed) + mathsx.perlin.noise_2d(x + 1, y - 1, i, seed) + mathsx.perlin.noise_2d(x - 1, y + 1, i, seed) + mathsx.perlin.noise_2d(x + 1, y + 1, i, seed)) / 16
        local sides = (mathsx.perlin.noise_2d(x - 1, y, i, seed) + mathsx.perlin.noise_2d(x + 1, y, i, seed) + mathsx.perlin.noise_2d(x, y - 1, i, seed) + mathsx.perlin.noise_2d(x, y + 1, i, seed)) / 8
        local center = mathsx.perlin.noise_2d(x, y, i, seed) / 4
        return corners + sides + center
end
 
function mathsx.perlin.interpolate_noise_2d(x, y, i, seed)
        local int_x = math.floor(x)
        local frac_x = x - int_x
 
        local int_y = math.floor(y)
        local frac_y = y - int_y
 
        local v1 = mathsx.perlin.smooth_noise_2d(int_x, int_y, i, seed)
        local v2 = mathsx.perlin.smooth_noise_2d(int_x + 1, int_y, i, seed)
        local v3 = mathsx.perlin.smooth_noise_2d(int_x, int_y + 1, i, seed)
        local v4 = mathsx.perlin.smooth_noise_2d(int_x + 1, int_y + 1, i, seed)
 
        local i1 = mathsx.perlin.cos_interpolate(v1, v2, frac_x)
        local i2 = mathsx.perlin.cos_interpolate(v3, v4, frac_x)
 
        return mathsx.perlin.cos_interpolate(i1, i2, frac_y)
end
 
function mathsx.perlin.noise2d(x, y, seed)
        local total = 0
        local p = mathsx.perlin.persistence
        local n = mathsx.perlin.octaves - 1
 
        for i = 0, n do
                local frequency = 2 ^ i
                local amplitude = p ^ i
 
                total = total + mathsx.perlin.interpolate_noise_2d(x * frequency, y * frequency, i, seed) * amplitude
        end
 
        return total
end