#!/usr/bin/env fish
set -l DIST_ID E3GKBJLB8I360P
set -l BUCKET hihorton.com

echo "Building Astro…"
npm run build; or exit 1

echo "Syncing dist/ to S3: $BUCKET…"
aws s3 sync ./dist s3://$BUCKET --delete; or exit 1

echo "Invalidating CloudFront: $DIST_ID…"
aws cloudfront create-invalidation --distribution-id $DIST_ID --paths "/*"; or exit 1

echo "✅ Deployed: https://$BUCKET"
