abstract type Temperature <: Number end
struct Celsius <: Temperature
    value
end
struct Fahrenheit <: Temperature
    value
end
struct Kelvin <: Temperature
    value
end
Base.show(io::IO, t::Temperature)   = print(io, "$(t.value)")
Base.show(io::IO, t::Kelvin)        = print(io, "$(t.value) K")
Base.show(io::IO, t::Fahrenheit)    = print(io, "$(t.value) F")
Base.show(io::IO, t::Celsius)       = print(io, "$(t.value) C")

promote_rule(::Type{Kelvin}, ::Type{Celsius})     = Kelvin
promote_rule(::Type{Fahrenheit}, ::Type{Celsius}) = Celsius
promote_rule(::Type{Fahrenheit}, ::Type{Kelvin})  = Kelvin

Base.convert(::Type{Kelvin},  t::Celsius)     = Kelvin(t.value + 273.15)
Base.convert(::Type{Kelvin},  t::Fahrenheit)  = Kelvin(Celsius(t))
Base.convert(::Type{Celsius}, t::Kelvin)      = Celsius(t.value - 273.15)
Base.convert(::Type{Celsius}, t::Fahrenheit)  = Celsius((t.value - 32)*5/9)
Base.convert(::Type{Fahrenheit}, t::Celsius)  = Fahrenheit(t.value*9/5 + 32)
Base.convert(::Type{Fahrenheit}, t::Kelvin)   = Fahrenheit(Celius(t))

Base. +(a::Temperature, b::Temperature) = +(promote(a,b)...)
Base. -(a::Temperature, b::Temperature) = -(promote(a,b)...)

Base. +(a::T, b::T) where {T <: Temperature} = T(a.value + b.value)
Base. -(a::T, b::T) where {T <: Temperature} = T(a.value - b.value)

Base. *(a::Number, b::T) where {T <: Temperature} = T(a * b.value)
Base. *(a::T, b::Number) where {T <: Temperature} = T(a.value * b)
Base. /(a::Number, b::T) where {T <: Temperature} = T(a / b.value)
