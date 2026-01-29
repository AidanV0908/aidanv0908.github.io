---
title:  "Controls from Zero"
date:   2026-01-16 23:25:00 -0700
category: projects
tags: gnc controls simulation
author: Aidan Velleca
description: "Modeling a control system"
published: false
header:
    teaser: "assets/images/control-sys.png"
---
# Background
The way I was taught controls in college was **flawed**. Why? The method my professors used approached the topic from an aggresively mathematical background, without giving the topics a proper introduction on a fundamental level. Math is a great tool, but its only useful when you **understand the premise of the problem you are trying to solve**. I used to think I was "weak" in controls, but it turns out I just never learned it properly. Today, I feel much more confident on how to design and implement PID controllers. In this post, I hope to explain the fundamentals behind control systems, especially PID control systems, to those who are new to the material. Welcome to Controls from Zero.

In my hunt for information on control systems, I found a lot of resources, but there are three that I feel helped me the most, which I wanted to share.
1. [Everything you need to know about control theory](https://www.mathworks.com/videos/everything-you-need-to-know-about-control-theory-1664864151410.html) by Brian Douglas
2. [Understanding PID Control](https://www.mathworks.com/videos/understanding-pid-control-part-1-what-is-pid-control--1527089264373.html) by Brian Douglas
3. [Why Laplace Transforms are useful](https://www.youtube.com/watch?v=FE-hM1kRK4Y) by 3Blue1Brown

Brian Douglas's series on MATLAB suited my learning style great, and 3Blue1Brown does a great job not just explaining how to perform a Laplace transform but also what is actually useful for, which is great.

# Control Systems
A control system fundamentally just tells your machine how to behave. The best I heard it put was as a "manager for machines." As an example, picture the HVAC system inside your house. The house is at some temperature when you modify the thermostat to 72&deg;F. The current temperature of the house is called the **state**, and the value you set the thermostat to is called the **reference** or **setpoint**. Depending on the difference between the state and reference, the HVAC system will either have to heat or cool the house to get it to the desired temperature. The control system is the mathematical model that governs the HVAC system's behavior.

There are two main categories of control systems, **feedforward** and **feedback**. Let's start with feedforward. Imagine you have a car, and you want to maintain a speed of 60 mph. You are given a function $f(u) = x$, where $u$, the **control input**, is the position of the gas pedal and $x$, the **control output**, is the speed of the car. In this system, once you set a reference speed $r$, you can use the inverse of the function to determine what position to set the gas pedal at to maintain that speed. This is a feedforward control system, because you are not using any information about the current state of the system to determine your input. You are just using your knowledge of how the system behaves to set your input.

Feedforward control systems sound great, but there are some problems when putting them into practice. For instance, let's say there is an extremely strong headwind while you are driving your car. This is not modeled in your function $f(u)$, so if you set your gas pedal to the position that would normally give you 60 mph, you will not actually be going 60 mph. In real life, systems tend to be unpredictable, and feedforward control systems do not handle this well. This is why feedback control systems are more commonly used.

There are multiple different type of feedback control systems. One important distinction is the difference between linear and non-linear systems. A linear system will follow the principles of what is known as superposition, which has two special properties. A nonlinear control system will not meet these specifications, and be harder to model. The two properties are:
* **Homogeneity**: if you increase the input by a certain factor, the output will scale by the same factor
* **Additivity**: if you add together two different inputs, their outputs will also be added

Another common classification of controllers is a PID controller. This is a controller with three terms added together.
* **Proportional**   
    * $u_p(t) = K_pe(t)$   
    * If there is a large error, increase the input.
* **Integral**   
    * $u_i(t) = K_i\int_{0}^{t} e(t) \,dt$   
    * This increases the input if the error has been large for a long time.
* **Derivative**   
    * $u_d(t) = K_d\frac{d}{dt}e(t)$   
    * This term reacts to the rate of change of error and helps damp oscillations.

For a PID controller, $u(t) = u_p(t) + u_i(t) + u_d(t)$.

# Simulation
I have explained to you some VERY foundational topics to control systems, but there is a lot more to cover. For instance, how do you properly set the gains on a PID controller? What are some things to look out for? As part of a mini project related to this fact finding mission, I created a simulation to visualize a PID controller. This simulation allows you to change the weights and see how the resulting system behaves. All of the code is on [GitHub](https://github.com/AidanV0908/PID-Simulation) for you to check out.

The simulation analyzes a mass spring system sliding on a flat surface. In previous iterations, I included a dampner, but to simplify the model, I ended up removing it. The system is therefore governed by the following systems of ODEs.

$v(t) = x'(t)$
$a(t) = (u(t) - kx(t)) / m$

Where:
* $x(t)$: position of the mass at time t
* $v(t)$: velocity of the mass at time t
* $a(t)$: acceleration of the mass at time t
* $u(t)$: control input at time t
* $k$: spring constant
* $m$: mass of the object

The initial conditions for the simulation are:

$x(0) = 0$ \\
$v(0) = 0$

The simulation makes the assumption of no friction, so the only forces acting on the mass are the spring force and the control input. The goal of the controller is to move the mass to some preset reference position r. This is one of the preset user variables. There are a couple pre-defined user variables. The first set of user variables are system variables, including:
* Mass ($m$): mass of the object
* Spring Constant ($k$): spring constant of the spring

The second set of user variables are controller variables, including:
* Proportional Gain ($K_p$): weight on the proportional term
* Integral Gain ($K_i$): weight on the integral term
* Derivative Gain ($K_d$): weight on the derivative term
* Reference Position ($r$): desired position of the mass

The third set of user variables are simulation variables, including:
* Time Step ($dt$): time step for the simulation
* Total Time ($T$): total time to simulate

From changing these variables, I am able to show you some interesting results. Here are some example plots from the simulation.

< insert example 1, a properly tuned PID controller plot >

< insert example 2, a PD controller plot with steady state error >

< insert example 3, a PD controller plot with oscillations >

# Issues with PID Control
While PID controllers are very common and useful, they do have some problems. One classic problem is **integral windup**. This is a common issue in real systems due to what's known as **saturation**. Imagine you have a motor, and you are using a PID controller to control its speed. The motor can only go so fast, so if your control input exceeds the maximum speed of the motor, the motor will just go at its maximum speed. This is saturation. If you then go past the setpoint, the controller will start to tell the motor to slow down, but the motors will stay at the same speed until the control input drops below the maximum speed again. This is undesirable behavior, but can be fixed with some anti-windup techniques.

Another issue is caused by the presence of high frequency noise. Imagine you have some noise described by $f(t) = A\sin(\omega t)$. The derivative of this term is $f'(t) = A\omega\cos(\omega t)$. As you can see, the derivative term is scaled by the frequency of the noise. This means that high frequency noise, even at low amplitudes, can be seen in the results. This is often fixed by adding a low-pass filter to the derivative term.

I won't cover anti-windup techniques or filtering techniques in this post, but I may cover them in a future post. I bring it up just to show that even though PID controllers are simple in theory, they are deceptively complex in practice, and there are a lot of things that could pop up. In the future, I may cover more advanced control techniques and add more situations to the simulation, so stay tuned!