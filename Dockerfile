FROM oven/bun:1 AS builder

WORKDIR /app

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .
RUN bun run --bun build

FROM oven/bun:1-slim

WORKDIR /app

COPY --from=builder /app/package.json ./
COPY --from=builder /app/build ./build

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000
EXPOSE 3000

CMD ["bun", "build/index.js"]
