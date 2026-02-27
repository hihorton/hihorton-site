#!/usr/bin/env fish
set -l DIST_ID E32ELCKWHN4541

npm run build; or exit 1
aws s3 sync ./dist s3://blog.hihorton.com --delete; or exit 1
aws cloudfront create-invalidation --distribution-id $DIST_ID --paths "/*"
echo "Deployed blog.hihorton.com"
