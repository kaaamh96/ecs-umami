FROM node:22-alpine AS deps

WORKDIR /app

COPY app/package.json app/pnpm-lock.yaml app/pnpm-workspace.yaml ./


#the package.json suggests that these files are important dependancies
COPY app/packages/api-client/package.json ./packages/api-client/
COPY app/packages/mcp/package.json ./packages/mcp/
COPY app/packages/mcp/bin ./packages/mcp/bin/


RUN apk add --no-cache libc6-compat
RUN npm install -g pnpm@12.3.4
RUN printf 'strictDepBuilds: false\n' >> pnpm-workspace.yaml
RUN pnpm install --frozen-lockfile