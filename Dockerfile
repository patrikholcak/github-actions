arg NODE_VERSION=16-alpine

from node:$NODE_VERSION as build
workdir /app
# Copy package.json and package-lock.json as distinct layer
copy package.json package-lock.json tsconfig.json .
run npm install --ci
# Run build
copy src ./src
run npm run build

# Create final image
from node:$NODE_VERSION
COPY --from=build /app/dist .

cmd ["node", "."]
