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


# stage 3 runner 


FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

RUN addgroup -S umami && adduser -S umami -G umami

COPY --from=builder /app/.next/standalone ./

COPY --from=builder /app/.next/static ./.next/static

COPY --from=builder /app/public ./public


# database 
COPY --from=builder /app/prisma ./prisma

COPY --from=builder /app/prisma.config.ts ./prisma.config.ts

COPY --from=builder /app/scripts ./scripts

COPY --from=builder /app/generated ./generated

CMD ["sh", "scripts/start-docker.sh"]


# runtime dependancies & permissions

RUN chown -R umami:umami /app

#port and start up commands

USER umami

ENV HOSTNAME="0.0.0.0"

ENV PORT=3000

EXPOSE 3000

CMD ["sh", "scripts/start-docker.sh"]