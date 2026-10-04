# Hack Club Media Gap Year Fellowship

This is the website for Hack Club's Media Gap Year Fellowship. Applications are closed.

This is a website (frontend only) built in Svelte.
<br>
In the development of this site, we took heavy inspiration from [Manitej](https://github.com/techpixel)'s [Manifesto](https://manifesto.hackclub.com/) while making this, as we wanted the overall structure of the two sites to match up and feel like a cohesive pair, or "sister sites" even.
<br>
This project was built with a team of 5 people, each doing their part, whether that was coding, writing, or designing it.

Development uses Bun 1.4.2. Install dependencies with `bun install --frozen-lockfile`, then run `bun run --bun dev`.

Build with `bun run --bun build` and start the production server with `bun run start`. Run `bun run --bun check` and `bun run --bun lint` for validation.

To run in Docker:

```sh
docker build -t media-fellowship .
docker run --rm -p 3000:3000 media-fellowship
```

TypeScript 7 is installed as `@typescript/native`. The `typescript` dependency aliases Microsoft's TypeScript 6 compatibility package because SvelteKit and `svelte-check` still require its compiler API. Keep both aliases when updating dependencies.

Linting uses Oxlint, and formatting uses Oxfmt (`bun run format`). Oxlint checks Svelte script blocks; Svelte diagnostics are checked with `bun run --bun check`.
