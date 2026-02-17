#!usr/bin/env sh
find . -type f -not -path './.git/*' -not -path './node_modules/*' -not -path './dist/*' -not -path './build/*' -print0 | xargs -0 sed -i 's/10\.119\.99\.124/10.119.64.4/g'
