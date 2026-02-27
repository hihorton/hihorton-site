---
title: 'How I Built blog.hihorton.com with AWS'
pubDate: 'Feb 26 2026'
description: 'Using S3, CloudFront, ACM, Cloudflare, and Astro to build a production-ready blog.'
heroImage: '../../assets/blog02.jpg'
---

## Why I Built This

I wanted a public place to document my AWS journey while building real cloud infrastructure instead of using a managed platform.

The goal was:
- Static hosting
- HTTPS everywhere
- CDN performance
- Low cost
- Production-style architecture

---

## Architecture Overview

The blog runs on:

- **Astro** (static site generator)
- **Amazon S3** (private bucket for static files)
- **CloudFront** (CDN + TLS termination)
- **ACM** (certificate management)
- **Cloudflare** (DNS + proxy)
- **AWS Budgets + SNS** (cost alerts)

Flow:

Browser → Cloudflare DNS → CloudFront → S3 (private origin)

---

## Step 1 – Build the Site

Astro generates static files into a `/dist` directory using:

npm run build

Those files are uploaded to S3 using:

aws s3 sync ./dist s3://blog.hihorton.com --delete

---

## Step 2 – Secure the Origin

The S3 bucket is private.

CloudFront uses **Origin Access Control (OAC)** to access the bucket.

This prevents direct public access to S3.

---

## Step 3 – HTTPS Everywhere

- ACM certificate issued in us-east-1
- CloudFront enforces HTTPS
- Cloudflare set to Full (strict)

---

## Step 4 – Cost Protection

I configured:

- AWS Budget alerts
- SNS email notifications
- Cost Anomaly Detection

This prevents surprise bills.

---

## What I Learned

- S3 bucket names are globally unique.
- ACM for CloudFront must be in us-east-1.
- CloudFront caching requires invalidation after deploy.
- DNS + CDN layers can cause redirect loops if misconfigured.
- Infrastructure discipline matters.

---

## What’s Next

- Add CI/CD pipeline
- Add project pages
- Diagram the architecture
- Begin EC2 lab experiments
