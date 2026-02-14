---
title:  "Controls from Zero"
date:   2026-01-16 23:25:00 -0700
category: projects
tags: wireguard homelab networking tunnels
author: Aidan Velleca
description: "Modeling a control system"
published: false
#header:
#    teaser: ""
seo_title: "Building a tunnel between vm and homelab with Tailscale"
seo_description: "A discussion on setting up a Tailscale tunnel between a VM and a homelab."
---
My infrastructure is currently split between two main locations: my homelab at home, and a VM hosted by my friend in Chicago. On the VM, I operate a minecraft server, whereas on my homelab, I run a few other services. I have a shared Grafana dashboard hosted on my homelab, but the traffic from the VM is shared over the open internet, which isn't ideal. That is why I started this project to create a secure tunnel between the two locations using Tailscale. Another benefit of this setup is that I can remove a Grafana and Prometheus instance from the VM. Instead, the prometheus instance on my homelab can scrape metrics from the VM over Tailscale. This reduces resource usage on the VM and simplifies management.

After installing Tailscale on both the VM and my homelab, both machines should be able to access each other with their Tailscale IP addresses. You can confirm this by trying `ping <other-tailscale-ip>` from each machine.