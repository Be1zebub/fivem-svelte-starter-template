import { vitePreprocess } from "@sveltejs/vite-plugin-svelte"

const isDev = true

export default {
	preprocess: vitePreprocess(),
	compilerOptions: {
		dev: isDev,
	},
}
