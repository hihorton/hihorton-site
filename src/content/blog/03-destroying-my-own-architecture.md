---
title: 'I Built It… Then I Deleted It'
description: 'How I built blog.hihorton.com, realized it was overcomplicated, and rebuilt everything simpler.'
pubDate: 'Feb 27 2026'
heroImage: '../../assets/blog03.jpg'
---

Yesterday I was feeling pretty proud.

I had:

- A landing page at `hihorton.com`
- A blog at `blog.hihorton.com`
- Two S3 buckets
- Two CloudFront distributions
- DNS records wired up
- Deploy scripts working

It felt official.

Then today… I deleted half of it.

---

## What Happened?

When I first built this, I separated everything:

- Landing page → one bucket
- Blog → different bucket
- Separate CloudFront distributions
- Separate DNS records

At the time, it made sense to me.

It felt organized.

But the more I worked with it, the more I realized something:

I was making it more complicated than it needed to be.

---

## The Realization

This isn’t a company website.

It’s just me.

I don’t have multiple teams.
I don’t need isolated environments.
I don’t need subdomain separation.

I just need:

hihorton.com

That’s it.

So I started asking myself:

Why am I maintaining two distributions?
Why am I deploying to two buckets?
Why am I managing extra DNS records?

Answer: I didn’t need to.

---

## So I Rebuilt It

I moved everything into one S3 bucket:

- `hihorton.com`
- Blog lives at `/blog`
- One CloudFront distribution
- One deploy script
- One origin
- One place to manage everything

Then I deleted:

- The old blog bucket
- The old CloudFront distribution
- The extra DNS record

It felt slightly terrifying.
But also… cleaner.

---

## What I Learned

I’m still new to all of this.

But here’s what this taught me:

- Just because something works doesn’t mean it’s the best design.
- Simpler is usually better.
- Deleting infrastructure is part of learning.
- I understand CloudFront way better now than I did yesterday.

Most importantly:

It’s okay to rebuild things.

---

## Why I’m Documenting This

I don’t want this blog to just show finished projects.

I want it to show the process.

The confusion.
The rebuilding.
The moments where something works… but could be better.
