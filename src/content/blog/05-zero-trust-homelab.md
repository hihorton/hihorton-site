---
title: 'Locking Down My Homelab with Zero Trust'
description: 'How I stopped exposing services directly to the internet and added real authentication using Cloudflare Tunnel and Cloudflare Access.'
pubDate: 'Mar 02 2026'
heroImage: '../../assets/blog05.jpg'
---

I had a problem.

I was exposing internal services to the internet.

The only thing standing between a stranger and my homelab was a login screen tied to Plex credentials.

That's it.

Just a lock on the front door.

---

## The Setup I Had

I run services on my homelab — things like Overseerr, accessible through a subdomain.

Cloudflare Tunnel handled the connection, which meant traffic was encrypted in transit.

But here's what I didn't think hard enough about:

Anyone who knew or stumbled across that subdomain could reach the login page.

Encrypted connection.

Still publicly reachable.

That's not good enough.

---

## Why I Didn't Just Forward a Port

I could have exposed a local port directly to the internet.

I chose not to.

Port forwarding means punching a hole in your network and pointing it at a device in your home.

Anyone scanning for open ports could find it.

Cloudflare Tunnel works differently — it creates an **outbound-only connection** from my server to Cloudflare.

Nothing is listening on my router.
No open ports.
No hole in the wall.

The tunnel reaches out. It doesn't let anything in uninvited.

That felt right.

But I still needed to control who could reach what was on the other side.

---

## What Zero Trust Actually Means

Zero Trust is a security model.

The idea is simple: don't trust anyone by default, even if they're already inside your network.

Every access request gets verified.
Every user gets the minimum access they need.
Nothing more.

I think about it like this:

I have a doctor's appointment on the 4th floor.
I'm given an elevator key that only goes to the 4th floor.
Not the 3rd. Not the 5th. Just where I need to be.

That's Zero Trust.

---

## What I Added

**Cloudflare Access.**

It sits in front of my tunnel and adds an authentication wall before anyone reaches a service.

Now when someone hits `seerr.hihorton.com`:

1. Cloudflare intercepts the request
2. They get a login prompt — not my app's login, Cloudflare's
3. A one-time PIN is sent to an approved email
4. Only then do they reach the service

If your email isn't on the list, you don't get in.

The app never even sees the request.

---

## Why This Is Better

Before:

```
Anyone → subdomain → login screen → inside
```

After:

```
Anyone → Cloudflare Access → verified email only → login screen → inside
```

Two layers now.

Cloudflare handles the first one before my app is ever involved.

---

## Scaling This Going Forward

The real value here is how it scales.

As I add more services to my homelab, each one gets a subdomain and gets put behind the same Access policy.

New service → tunnel → Access policy applied → done.

I don't have to think about auth for every individual app.

One policy. Every service covered.

---

## What I Learned

- An encrypted connection isn't the same as a secure one. Encryption protects data in transit. Access controls protect what's on the other end.
- Outbound-only tunnels are cleaner and safer than port forwarding.
- Zero Trust isn't just an enterprise concept. It applies at any scale.
- Adding security in layers means no single failure exposes everything.

---

## What's Next

- Cloudwatch monitoring for my AWS infrastructure
- Serverless contact form with API Gateway + Lambda + SES
- Document the full homelab architecture
