# Rocket Flight Dynamics Simulation — MATLAB/Simulink

A 2D rocket trajectory simulator built in MATLAB/Simulink, modelling the full dynamics of a rocket from launch through orbital insertion. 
The simulation uses a **perifocal coordinate system** and integrates gravitational, aerodynamic, and thrust forces using a modular 
Simulink architecture.

---

## Features

- **ISA Atmosphere Model** — multi-layer altitude-dependent air density and pressure (troposphere, stratosphere, mesosphere), implemented as a Simulink subsystem with Switch blocks
- **Aerodynamic Forces** — drag and lift computed from velocity, air density, and reference cross-sectional area
- **Inverse-Square Gravity** — altitude-dependent gravitational acceleration, not a simplified constant-g model
- **Variable Mass Dynamics** — rocket mass decreases over time as propellant is consumed (mass flow rate parameter)
- **MATLAB Function Block** — encodes the full ODE system derived from Newton's 2nd law in perifocal coordinates
- **Stateflow Hybrid Controller** — flight phase logic (DEVS + DESS hybrid system) with states: `Boost → Speed_Reached → Turn → Stop_Thrust`
- **Two Simulation Scenarios** — near-Earth ballistic trajectory and Earth-orbital insertion
- **Automatic Parameter Loading** — initial conditions and rocket parameters defined in a separate MATLAB script that loads automatically on model open

---

## Model Architecture

The Simulink model is structured as a set of modular subsystems feeding into a central MATLAB Function block:

```
params.m (auto-load)
    │
    ├──► Earth Atmosphere Model ──► Aerodynamic Forces ──┐
    ├──► Weight subsystem ─────────────────────────────── ┤
    ├──► Stateflow Chart (F_thrust, cmd_angle, ballistic)─┤
    │         ▲                                           │
    │    (W, height, speed, angle feedback)               ▼
    │                                         Rocket Dynamics
    │                                         (MATLAB Function)
    │                                                │
    │                                                ▼
    └────────────── Integrators (Vr, Vv, m, theta) ◄─┘
                           │
                           ▼
                    Re blocks (polar → Cartesian)
                           │
                           ▼
                    out.xout / out.yout
```

---

## Equations of Motion

The dynamics are derived from Newton's second law in **perifocal coordinates** (r, θ):

```
dr/dt   = v_r
dθ/dt   = v_θ / r
dv_r/dt = v_θ²/r − g(r) + (T·sin(α) − D·sin(γ)) / m
dv_θ/dt = −v_r·v_θ/r + (T·cos(α) − D·cos(γ)) / m
dm/dt   = −ṁ
```

Where:
- `g(r) = g₀ · (R₀ / r)²` — inverse-square gravity
- `T` — thrust force, `D` — aerodynamic drag
- `α` — thrust angle, `γ` — flight path angle
- `ṁ` — propellant mass flow rate

**Atmospheric density** is computed via the ISA standard model:

```
ρ(h) = p(h) / (R_specific · T(h))
```

with piecewise temperature and pressure profiles per atmospheric layer.

---

## Simulation Results



### Earth-Orbital Trajectory
<img width="548" height="495" alt="image" src="https://github.com/user-attachments/assets/ae8cb6ab-3c45-45d5-9b62-0ffde448acec" />
<img width="625" height="563" alt="image" src="https://github.com/user-attachments/assets/d2166593-5bba-4837-aeaa-a41f6220e316" />




---

## Getting Started

### Requirements
- MATLAB R2021a or later
- Simulink
- Aerospace Toolbox (optional, for reference comparisons)

### Running the Simulation
1. Clone this repository
2. Open MATLAB and navigate to the project folder
3. Open `rocket_simulation.slx` — the parameter script loads automatically
4. Press **Run** in Simulink
5. After simulation completes, run `visualize_trajectory.m` to plot the trajectory

### Adjusting Parameters
Edit the parameter script to change:
- Initial mass, propellant mass, mass flow rate
- Thrust magnitude and direction profile
- Launch angle and initial velocity
- Simulation duration

---

## Project Structure

```
rocket-dynamics-simulink/
│
├── rocket_simulation.slx       # Main Simulink model
├── params.m                    # Initial conditions and parameters (auto-loads)
├── visualize_trajectory.m      # Trajectory plotting script
├── README.md
```

---

## References

- Curtis, H. D. *Orbital Mechanics for Engineering Students*, 4th Edition. Butterworth-Heinemann, 2020.
- Sutton, G. P. & Biblarz, O. *Rocket Propulsion Elements*, 9th Edition. Wiley, 2017.
- NASA Glenn Research Center. [Earth Atmosphere Model — Metric Units](https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html)
- Utah State University, MAE 5540 — Propulsion Systems, Section 3: Flight Performance
