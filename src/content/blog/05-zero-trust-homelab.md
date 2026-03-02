---
title: 'Locking Down My Homelab'
description: 'Adding Cloudflare Access in front of my homelab services and learning what Zero Trust actually means in practice.'
pubDate: 'Mar 02 2026'
heroImage: '../../assets/blog05.jpg'
---

I've been running a few internal services on my homelab, exposed through Cloudflare Tunnel so I can reach them remotely.

The tunnel itself gives me an encrypted connection without opening ports on my router, which I liked. Outbound only. Nothing listening on my network from the outside.

But there was still a problem.

Anyone who found one of my subdomains could hit the login page. The only thing stopping them was whatever auth the app had built in.

That felt like one lock on a door I'd rather keep hidden entirely.

---

## What I Added

Cloudflare Access sits in front of the tunnel and intercepts requests before they ever reach the app.

Now when I navigate to one of my subdomains, Cloudflare prompts for authentication first — a one-time PIN sent to an approved email. If your email isn't on the list, you never see the app.

Setup was straightforward. I created a policy in Cloudflare Zero Trust, attached it to the application, and that was it.

---

## Why This Matters to Me

I've been reading about Zero Trust as a concept and this was the first time I actually implemented something that fits the model.

The way I understand it: don't assume access should be granted just because someone is at the door. Verify first, and only give access to what's needed.

I think about it like having a doctor's appointment on the 4th floor. You get an elevator key that only goes to the 4th floor. Not the whole building — just where you need to be.

That's roughly what I set up here. Each service gets its own application in Cloudflare Access, scoped to only the people who should reach it.

---

## Going Forward

As I add more services to my homelab the pattern stays the same — tunnel plus Access policy before anything is reachable. It's a habit I want to build now rather than go back and retrofit later.

It also made me think more carefully about the AWS side of things. I've been applying similar thinking there — IAM users scoped to only what they need, credentials that never live in code. Same idea, different context.

Still a lot to learn but this felt like a meaningful step.
