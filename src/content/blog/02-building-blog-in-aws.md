---
title: 'How I Built hihorton.com on AWS'
pubDate: 'Feb 26 2026'
description: 'Using S3, CloudFront, ACM, Cloudflare, and Astro to build a production-style site.'
heroImage: '../../assets/blog02.jpg'
---

I wanted a place to document what I'm learning without just handing it off to a managed platform like WordPress or Ghost.

I had been running both of those on a local server at home. They worked, but they were more than I needed. And every time I wanted to test something in my homelab, I risked taking my own website offline. I wanted the site off my local network entirely.

GitHub Pages was an option but I wanted something more flexible and a reason to get hands-on with AWS.

So I built it myself.

---

## What I'm Running

The site is built with Astro — a static site generator that outputs plain HTML, CSS, and JavaScript into a `/dist` folder. No server needed to run it.

Those files live in a private S3 bucket. CloudFront sits in front of it, handles HTTPS via an ACM certificate, and serves the content through a CDN. Cloudflare manages DNS and redirects. AWS Budgets and SNS send me alerts if costs do anything unexpected.

The flow end to end:

```
Browser → Cloudflare DNS → CloudFront → S3 (private origin)
```

---

## A Few Things Worth Noting

The S3 bucket is private. CloudFront accesses it through Origin Access Control, which means there's no direct public path to the bucket. Everything goes through CloudFront.

ACM certificates for CloudFront have to be issued in us-east-1 regardless of where everything else lives. That caught me off guard the first time.

CloudFront caches content at edge locations, which means after a deploy I have to invalidate the cache or visitors might see an older version of the site. That's now part of my deploy process.

Cloudflare needed to be set to Full (strict) mode to avoid redirect loops between it and CloudFront. Two HTTPS layers talking to each other incorrectly will just loop forever.

---

## What I Learned

Most of the friction wasn't in any one service — it was in getting them to work together correctly. DNS, CDN, certificates, and origin access all have to be configured with each other in mind.

I also set up cost alerts early, which felt overly cautious at first. Static hosting on S3 and CloudFront is cheap. But knowing that a misconfiguration or unexpected traffic won't result in a surprise bill let me focus on building instead of worrying.

---

## What's Next

- CI/CD pipeline so deploys happen automatically on push
- Project pages to document builds
- EC2 experiments in a lab environment
