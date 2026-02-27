# hihorton-site

Personal website and cloud lab project for **Michael Horton**.\
Built with Astro and deployed on AWS as part of my Cloud Computing
specialization journey.

This project serves two purposes:

1.  A personal website (hihorton.com)\
2.  A hands-on AWS lab environment for learning real-world cloud
    architecture

------------------------------------------------------------------------

## 🚀 Tech Stack

-   **Astro** -- Static site framework\
-   **Node.js** -- Build environment\
-   **AWS S3** -- Static site hosting\
-   **AWS CloudFront** -- CDN + HTTPS\
-   **AWS IAM** -- Access control\
-   **AWS CLI** -- Deployment automation\
-   *(Planned)* CloudFront Logs + Athena for analytics

------------------------------------------------------------------------

## 🏗 Architecture Overview

Astro build\
↓\
`dist/` output\
↓\
AWS S3 (static hosting bucket)\
↓\
CloudFront distribution\
↓\
hihorton.com

### Planned Enhancements

-   CloudFront access logging to S3\
-   Athena queries for traffic analysis\
-   WAF integration\
-   CI/CD via GitHub Actions

------------------------------------------------------------------------

## 📦 Local Development

Install dependencies:

``` bash
npm install
```

Run development server:

``` bash
npm run dev
```

Build production files:

``` bash
npm run build
```

Preview production build:

``` bash
npm run preview
```

------------------------------------------------------------------------

## 🚀 Deployment Script

Deployment is automated via a custom Fish shell script:

``` fish
#!/usr/bin/env fish
set -l DIST_ID E3GKBJLB8I360P
set -l BUCKET hihorton.com

echo "Building Astro…"
npm run build; or exit 1

echo "Syncing dist/ to S3: $BUCKET…"
aws s3 sync ./dist s3://$BUCKET --delete; or exit 1

echo "Invalidating CloudFront: $DIST_ID…"
aws cloudfront create-invalidation --distribution-id $DIST_ID --paths "/*"; or exit 1

echo "Deployed: https://$BUCKET"
```

This script: 1. Builds the site\
2. Syncs to S3\
3. Invalidates CloudFront cache

------------------------------------------------------------------------

## 🎯 Purpose

This site is intentionally simple.

It exists as:

-   A cloud engineering sandbox\
-   A resume-supporting project\
-   A foundation for future infrastructure experiments

As I progress toward AWS certifications (SAA → Security → DevOps), this
repository will evolve alongside my skills.

------------------------------------------------------------------------

## 📈 Roadmap

-   [ ] Enable CloudFront logging\
-   [ ] Build Athena traffic dashboard\
-   [ ] Configure AWS WAF\
-   [ ] Implement GitHub Actions CI/CD\
-   [ ] Expand blog content\
-   [ ] Add architecture diagram

------------------------------------------------------------------------

## 🧠 Why This Exists

This project serves as proof of applied cloud knowledge.

Instead of only studying AWS, this repository demonstrates:

-   Infrastructure design\
-   IAM best practices\
-   Deployment automation\
-   Scalability and cost awareness

------------------------------------------------------------------------

## 📜 License

Personal project --- not licensed for redistribution.
