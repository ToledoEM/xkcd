#!/usr/bin/env bash
set -euo pipefail

# Build pkgdown site
Rscript -e "pkgdown::build_site()"

# Copy the Figure Pose Helper into the rendered site
mkdir -p docs/stickfigurehelper
cp stickfigurehelper/index.html docs/stickfigurehelper/index.html

echo "Site built. Helper available at docs/stickfigurehelper/index.html"
