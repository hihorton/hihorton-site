---
title: 'I Automated My Deployments'
description: 'How I replaced my manual deploy script with a CI/CD pipeline using GitHub Actions and AWS IAM.'
pubDate: 'Mar 01 2026'
heroImage: '../../assets/blog04.jpg'
---

Every time I made a change to my site, I had to do two things.

Push the code to GitHub, then run my deploy script.

It worked, but I was already pushing to GitHub anyway. Running the script separately was a redundant step I had to remember every single time.

---

## The Old Way

I had a fish shell script that built the Astro site, synced the output to S3, and invalidated the CloudFront cache. Every deploy meant opening a terminal and running it by hand.

It wasn't broken. But the more I learned about CI/CD the more it felt like I was halfway there and stopping short.

---

## What I Changed

I added a workflow file at `.github/workflows/deploy.yml` that runs the same steps automatically whenever I push to `main`. GitHub spins up an environment, installs dependencies, builds the site, syncs to S3, and invalidates the cache.

Same process as the script. Just no longer something I have to think about.

---

## The Security Side

Moving to GitHub Actions also pushed me to fix something I had been ignoring.

My deploy script had the S3 bucket name and CloudFront distribution ID sitting in plaintext. Not credentials, but still information I didn't need in my codebase.

With GitHub Actions those values live as encrypted repository secrets. I also created a separate IAM user specifically for deployments — scoped only to S3 and CloudFront, nothing else. My personal admin account stays separate from anything automated.

It's the same principle I've been applying elsewhere. The deploy process shouldn't carry more access than it actually needs.

---

## What I Took Away

The automation itself was straightforward once I understood what was happening. The more interesting part was realizing how much of the security improvement came as a side effect of doing it the right way — credentials out of the codebase, least privilege IAM user, no manual steps that could be skipped or forgotten.

Pushing to `main` now means the site is updated. That's it.

---

## What's Next

- CloudWatch monitoring for traffic and errors
- Serverless contact form with API Gateway + Lambda + SES
- Full architecture diagram
