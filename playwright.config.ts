import { defineConfig } from '@playwright/test';

export default defineConfig({
	webServer: { command: 'bun run --bun build && bun run --bun preview', port: 4173 },
	testMatch: '**/*.e2e.{ts,js}'
});
