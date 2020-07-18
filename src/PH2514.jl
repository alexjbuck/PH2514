module PH2514

import Base
# Write your package code here.
export C, λ_cf, f_cλ, f_hE, E_hf, E_Zn, Energy, ElectronVolt, Joule, eV, J, Wavelength, Frequency, WiensDisplacementLaw, SteffannBoltzman, Vrms, GyroRadius, GyroFrequency, PlasmaFrequency

C = Dict(
    :c => 299792458,
    :h => 6.626e-34,
    :J2eV => 6.242e18,
    :eV2J => 1.602e-19,
    :E1 => -13.58,
    :k => 1.380649e-23,
    :σ => 5.67e-8,
    :a =>2.898e-3,
    :me => 9.10938356e-31,
    :mp => 1.6726e-27,
    :qe => 1.60217662e-19,
    :ϵ0 => 8.85418e-12,
)

abstract type Unit <: Number end
abstract type Energy <: Unit end
struct ElectronVolt <: Energy
    value::Number
end
struct Joule <: Energy
    value::Number
end
struct Wavelength <: Unit
    value::Number
end
struct Frequency <: Unit
    value::Number
end
promote_rule(::Type{Number},    ::Type{Unit})           = Unit
promote_rule(::Type{Unit},      ::Type{Number})         = Unit
promote_rule(::Type{Joule},     ::Type{ElectronVolt})   = Joule
promote_rule(::Type{Number},    ::Type{Frequency})      = Frequency
promote_rule(::Type{Frequency}, ::Type{Number})         = Frequency
promote_rule(::Type{Number},    ::Type{Wavelength})     = Wavelength
promote_rule(::Type{Wavelength},::Type{Number})         = Wavelength

ElectronVolt(J::Joule)  = convert(ElectronVolt,J)
ElectronVolt(f::Frequency) = convert(ElectronVolt,f)
ElectronVolt(λ::Wavelength) = convert(ElectronVolt,λ)
Joule(eV::ElectronVolt) = convert(Joule,eV)
Joule(f::Frequency) = convert(Joule,f)
Joule(λ::Wavelength) = convert(Joule,λ)

Wavelength(f::Frequency) = convert(Wavelength,f)
Frequency(λ::Wavelength) = convert(Frequency,λ)
Wavelength(e::Energy)    = convert(Wavelength,e)
Frequency(e::Energy)     = convert(Frequency,e)

Base.convert(::Type{ElectronVolt},  t::Joule)           = ElectronVolt(t.value * C[:J2eV])
Base.convert(::Type{Joule},         t::ElectronVolt)    = Joule(t.value * C[:eV2J])

Base.convert(::Type{Wavelength},    t::Frequency)       = Wavelength(C[:c] / t.value)
Base.convert(::Type{Frequency},     t::Wavelength)      = Frequency(C[:c] / t.value)

Base.convert(::Type{Frequency},     t::Energy)          = Frequency(convert(Joule,t).value / C[:h])
Base.convert(::Type{Joule},         t::Frequency)       = Joule(C[:h] * t.value)
Base.convert(::Type{ElectronVolt},  t::Frequency)       = ElectronVolt(convert(Joule,t))
Base.convert(::Type{Joule},         t::Wavelength)      = convert(Joule,Frequency(t))
Base.convert(::Type{ElectronVolt},  t::Wavelength)      = convert(ElectronVolt,Frequency(t))

Base.convert(::Type{Number},        t::Unit)            = Number(t.value)
Base.convert(::Type{Unit},          t::Number)          = Unit(t)
Base.convert(::Type{Wavelength},    t::Number)          = Wavelength(t)
Base.convert(::Type{Frequency},     t::Number)          = Frequency(t)

Base. +(a::Joule,b::Joule) = Joule(a.value + b.value)
Base. -(a::Joule,b::Joule) = Joule(a.value + b.value)
Base. +(a::ElectronVolt,b::ElectronVolt) = ElectronVolt(a.value + b.value)
Base. -(a::ElectronVolt,b::ElectronVolt) = ElectronVolt(a.value + b.value)
Base. +(a::Wavelength,b::Wavelength) = Wavelength(a.value + b.value)
Base. -(a::Wavelength,b::Wavelength) = Wavelength(a.value + b.value)
Base. +(a::Frequency,b::Frequency) = Frequency(a.value + b.value)
Base. -(a::Frequency,b::Frequency) = Frequency(a.value + b.value)

Base. -(a::Unit,b::Number) = -(promote(a,b)...)
Base. +(a::Unit,b::Number) = +(promote(a,b)...)
Base. *(a::Unit,b::Number) = *(promote(a,b)...)
Base. ÷(a::Unit,b::Number) = ÷(promote(a,b)...)
Base. *(a::Unit,b::Unit)   = *(promote(a,b)...)


function Base.show(io::IO, J::Joule)
    print(io, "$(J.value) J")
end

function Base.show(io::IO, e::ElectronVolt)
    print(io, "$(e.value) eV")
end

function Base.show(io::IO, λ::Wavelength)
    print(io, "$(λ.value) m")
end

function Base.show(io::IO, f::Frequency)
    print(io, "$(f.value) Hz")
end


const J = Joule
const eV = ElectronVolt

λ_cf(f::Frequency) = Wavelength(f)

f_cλ(λ::Wavelength) = Frequency(λ)

f_hE(E::Energy) = Frequency(E)

E_hf(f::Frequency) = Joule(f)

function E_Zn(Z,n)
    C[:E1] * (Z/n)^2
end

function WiensDisplacementLaw(T)
    C[:a]/T
end

function PlanckRadiation_L(λ,T)
    2 * C[:h] * C[:c]^2 / λ^5 / ( exp(C[:h]*C[:c]/(λ*C[:k]*T)) - 1)
end

function SteffannBoltzman(ϵ,T)
    C[:σ] * ϵ * T^4
end

function Vrms(m,T)
    √(3 * C[:k] * T / m)
end

function GyroRadius(m,v,q,B)
    (m*v) / (q*B)
end

function GyroFrequency(q,B,m)
    q*B/m
end

function PlasmaFrequency(n)
    √((n * C[:qe]^2)/(C[:ϵ0]*C[:me]))
end

end
