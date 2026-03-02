---
title: 'I Automated My Deployments'
description: 'How I replaced my manual deploy script with a CI/CD pipeline using GitHub Actions and AWS IAM.'
pubDate: 'Mar 01 2026'
heroImage: '../../assets/blog04.jpg'
---

Every time I made a change to my site, I had to do two things.

Push the code to GitHub.

Then run my deploy script.

It worked.

But it was manual.

And one of those steps was redundant.

---

## The Old Way

I had a fish shell script that did three things:

1. Build the Astro site
2. Sync the output to S3
3. Invalidate the CloudFront cache

Every deploy meant opening a terminal, navigating to the project, and running it by hand.

It wasn't broken.

But it wasn't automated either.

---

## The Problem I Noticed

GitHub already had my code.

Every push was version controlled, tracked, backed up.

But the actual deployment still depended on me remembering to run a script.

That's not a pipeline.

That's just a habit.

---

## What CI/CD Actually Means

CI/CD stands for Continuous Integration / Continuous Deployment.

The idea is simple:

When you push code → it builds → it deploys. Automatically.

No extra steps.
No manual triggers.
No forgetting.

GitHub Actions is the tool that makes this happen inside your GitHub repo.

---

## What I Built

I added a workflow file at `.github/workflows/deploy.yml`.

Now when I push to `main`:

1. GitHub spins up a fresh Ubuntu environment
2. Installs Node.js
3. Runs `npm ci` to install dependencies
4. Builds the Astro site
5. Syncs the output to S3
6. Invalidates the CloudFront cache

The same steps my script was doing.

Just automatic.

---

## The Security Upgrade

My old script had my S3 bucket name and CloudFront distribution ID sitting in plaintext.

Anyone who could read my script could see them.

With GitHub Actions, those values are stored as **repository secrets** — encrypted, never exposed in code.

I also created a dedicated IAM user just for deployments.

Not my personal admin account.

A separate user with one policy: access only to S3 and CloudFront.

Nothing else.

This is called **least privilege** — only grant what's needed to do the job.

If those credentials ever leaked, the damage would be limited.

That's the right way to do it.

---

## The New Flow

Before:

```
git push → manually run deploy script → site updates
```

After:

```
git push → site updates
```

That's it.

---

## What I Learned

- CI/CD isn't complicated. It's just automation applied to deployment.
- Least privilege matters even on personal projects. Build the habit now.
- GitHub Secrets keep sensitive values out of your codebase.
- A push to `main` should mean something. Now it does.

---

## What's Next

- Add CloudWatch monitoring to track traffic and errors
- Build a serverless contact form using Lambda + API Gateway + SES
- Document the full architecture with a diagram
