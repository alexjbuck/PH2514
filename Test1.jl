using PH2514

# Question 1
# What is the Energy (in electron Volts - eV) associated with radiation at 13 micrometers? (Do not include units with your answer)
eV(Wavelength(13e-6))

# Question 2
# Transitions to the n = 5 state of the hydrogen atom are known as the
# Pfund

# Question 3
# What is the ground state energy for a Lithium ion, in eV? (Note that Z=3, the ground state energy for hydrogen is -13.58 eV). Enter the absolute value of your answer, i.e. don't enter the minus sign or list any units.
E_Zn(3,1)


# Question 4
# Calculate the energy for the hydrogen transition from N=5 to N=3, in electron Volts (eV). Do not enter units with your answer. Positive (absolute) value.
E_Zn(1,5)-E_Zn(1,3)

# Question 5
# Calculate the wavelength for the peak of blackbody radiation at T = 5000 K. (Do not include units with your answer).
Wavelength(WiensDisplacementLaw(5000))

# Question 6
# Use the Stefan Boltzman Law to calculate the radiated power, in Watts, of a gray body at 97 K (boiling point of liquid nitrogen), emissitivity = 0.9 and surface area = 2 m2. (Do not enter units with your answer). Note the difference between a gray body and a blackbody is the emissivity.
SteffannBoltzman(.9,97)* 2

# Question 7
# Kinetic Theory: For a helium gas, atoms with a temperature of 1100 K have a random (rms) velocity of:
Vrms(6.6464731e-27,1100)

# Question 8
# Plasma Physics: Gyroradius: For an electron with velocity of 527 km/s (5.27x105 m/s), Magnetic field of 150 x 10-9 Tesla (150 nanoTesla); calculate the gyroradius in meters. Do not enter the units with your answer.
GyroRadius(C[:me],5.27e5,C[:qe],150e-9)

# Question 9
# Plasma Physics: Gyrofrequency: For an electron with velocity of 527 km/s, Magnetic field of 150 x 10-9 Tesla (150 nT); calculate the gyrofrequency in Hz (not radians per second; f, not omega). Do not enter the units with your answer.
GyroFrequency(C[:qe],150e-9,C[:me]) / (2*π)

# Question 10
# Plasma Physics: Plasma Frequency:  Electrons with a density of 2x106 e/m3 are present.  Calculate the plasma frequency in KHz. (not radians per second). (Enter answer without units)
PlasmaFrequency(2e6)/2/π/1e3

# Question 11
# The direction of propagation of an electromagnetic wave is perpendicular to the magnetic field and parallel to the electric field.
False

# Question 12
# A magnetic field that is 'frozen' into a plasma will move with the plasma as it moves.
True

# Question 13
# A magnetic field can be considered as also exerting magnetic pressure.
True

# Question 14
# What is the drift velocity for a proton in a magnetic field of 35 micro Tesla with a perpendicular electric field of 1.5 mV/meter?
vD = 1.5e-3 / 35e-6

# Question 15
# If you double the magnetic field, what happens to the gyro radius?
# It halves
