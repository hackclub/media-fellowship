# Hack Club Media Gap Year Fellowship

We're hiring two teens this year to be the face of Hack Club's social media, and this is the website for the application!

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
