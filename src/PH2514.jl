module PH2514

# Write your package code here.
export C, λ_cf, f_cλ, E_hf, E_Zn

C = Dict(
    :c => 3e8,
    :h => 6.626e-34,
    :J2eV => 6.242e18,
    :E1 => -13.58
)

function λ_cf(f)
    C[:c] * f end
end
function f_cλ(λ)
    C[:c] / λ
end
function E_hf(f)
    C[:h] * f
end
function E_hf(f,unit::Symbol)
    if unit == :J
        E_hf(f)
    elseif unit == :eV
        E_hf(f) * C[:J2eV]
    end
end
function E_Zn(Z,n)
    C[:E1] * (Z/n)^2
end
