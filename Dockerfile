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



#stage 2 - build stage 


FROM node:22-alpine AS builder

WORKDIR /app

RUN npm install -g pnpm@12.3.4

COPY --from=deps /app/node_modules ./node_modules

COPY --from=deps /app/packages/api-client/node_modules ./packages/api-client/node_modules

COPY --from=deps /app/packages/mcp/node_modules ./packages/mcp/node_modules

COPY app/ ./

COPY app/docker/proxy.ts ./src/

#ENV NEXT_TELEMETRY_DISABLED=1 keeping project limited to what it needs 

ENV DATABASE_URL="postgresql://user:pass@localhost:5432/dummy"

RUN pnpm build:docker