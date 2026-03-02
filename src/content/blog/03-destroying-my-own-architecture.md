---
title: 'I Built It… Then I Deleted It'
description: 'How I built hihorton.com, realized it was overcomplicated, and rebuilt everything simpler.'
pubDate: 'Feb 27 2026'
heroImage: '../../assets/blog03.jpg'
---

Yesterday I was feeling pretty proud.

I had a landing page at `hihorton.com`, a blog at a separate subdomain, two S3 buckets, two CloudFront distributions, DNS records wired up, and deploy scripts working.

It felt official.

Then today I deleted half of it.

---

## What Happened

When I first built this I separated everything. Landing page in one bucket, blog in another, separate distributions, separate DNS records.

At the time it made sense. It felt organized.

But the more I worked with it the more I realized I was making it more complicated than it needed to be. I kept asking myself why I was maintaining two distributions, deploying to two buckets, managing extra DNS records.

This isn't a company with multiple teams or isolated environments. It's just me and one domain.

---

## So I Rebuilt It

I moved everything into one S3 bucket. The blog lives at `/blog`, one CloudFront distribution, one deploy script, one place to manage everything.

Then I deleted the old bucket, the old distribution, and the extra DNS record.

It felt slightly terrifying. But also cleaner.

---

## What I Took Away

Just because something works doesn't mean it's the right design. I went back and asked whether the complexity I added was solving a real problem or just something I carried over from how I imagined it should look.

It wasn't. So I simplified it.

Deleting infrastructure I built myself was a weird feeling but it taught me more about how CloudFront actually works than building it the first time did.

---

## Why I'm Writing This Down

I don't want this blog to only show finished things. The rebuilding and the moments where something works but could be better are just as worth documenting.
