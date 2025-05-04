import { svelte } from "@sveltejs/vite-plugin-svelte"
import path from "path"
import { defineConfig } from "vite"

const isDev = true

export default defineConfig({
	plugins: [svelte()],
	base: "./",
	resolve: {
		alias: {
			$lib: path.resolve(__dirname, "./src/lib"),
			$components: path.resolve(__dirname, "./src/lib/components"),
			$providers: path.resolve(__dirname, "./src/lib/providers"),
			$store: path.resolve(__dirname, "./src/lib/store"),
			$utils: path.resolve(__dirname, "./src/lib/utils"),
			$views: path.resolve(__dirname, "./src/lib/views"),
			$config: path.resolve(__dirname, "./src/lib/config"),
		},
	},
	optimizeDeps: {
		include: ["@sveltejs/vite-plugin-svelte"],
	},
	build: isDev && {
		minify: isDev ? false : "esbuild",
		sourcemap: isDev ? "inline" : false,
		target: "esnext",
	},
})
