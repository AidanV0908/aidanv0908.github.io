---
title:  "Controls from Zero"
date:   2026-01-16 23:25:00 -0700
category: projects
tags: gnc, controls
author: Aidan Velleca
description: "Modeling a control system"
published: true
header:
    teaser: "assets/images/control-sys.png"
---
When I was in controls class in university, I found that it was very common for professors to introduce controls-related topics discretely, not really emphasizing how all of these topics tie together. For things like Bode plots, Nyquist diagrams, Laplace transformations, and more, you may get a detailed explanation of how to do these things, but the end goal might not be as obvious. Which is why I decided to write this post about how to deal with control systems, going back to the basics.

The best way to think about control systems is as a manager for a machine. You want your machine to reach a certain state, but you might not be there yet. For example, your house may be at 63&deg;F on a chilly day, and you set the thermostat to 72&deg;F. 63&deg;F would be your current state, 72&deg;F would be your reference, and your input might be the level the heater is set to. 

There are two main categories of control systems, **feedforward** and **feedback**. Imagine a world where you know exactly what the dynamics of a system you are working with looks like. A helpful example of this is in [this video](https://www.youtube.com/watch?v=lBC1nEq0_nk&t=5s) produced by MATLAB. If you know your reference speed and had a relationship $x=f(u)$ between the pedal position (u) and speed (x) with no disturbances, you could use the inverse to determine the position of the pedal you want. However, in a real system, there might be unpredictable factors that make a feedforward model impractical. As mentioned in the MATLAB video during the autonomous car example, there may be wind, bumps in the road, pedestrians to stop for, etc, that are not properly modeled and may cause your system to break down. In a pure feedforward control system, unmodeled disturbances can cause drift, meaning the error may grow over time. That is where a feedback model comes into play. A feedback model will use sensors to measure the state, and then "feed it back" into the model. Since sensors are not perfectly accurate, you will also need to model in some noise to your measurements. These are the base fundamentals of control systems, and what each value "means."

There are multiple different type of control systems. One important distinction is the difference between linear and non-linear systems. A linear system will follow the principles of what is known as superposition, which has two special properties. A nonlinear control system will not meet these specifications, and be harder to model. The two properties are:
* Homogeneity: if you increase the input by a certain factor, the output will scale by the same factor
* Additivity: if you add together two different inputs, their outputs will also be added

Another common classification of controllers is a PID controller. This is a controller with three terms added together.
* Proportional: $u_p(t) = K_pe(t)$. If there is a large error, increase the input.
* Integral: $u_i(t) = K_i\int_{0}^{t} e(t) \,dt$. This increases the input if the error has been large for a long time.
* Derivative: $u_d(t) = K_d\frac{d}{dt}$e(t). This term reacts to the rate of change of error and helps damp oscillations.

For a PID controller, $u(t) = u_p(t) + u_i(t) + u_d(t)$.

As part of a mini project related to this fact finding mission, I created a simulation to visualize a PID controller. This simulation allows you to change the weights and see how the resulting system behaves. Check it out on [GitHub](https://github.com/AidanV0908/PID-Simulation). Next, I plan to talk more about assessing stability.