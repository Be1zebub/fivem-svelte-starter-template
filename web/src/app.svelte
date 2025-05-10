<script>
	import { config as fontAwesomeConfig } from "@fortawesome/fontawesome-svg-core"
	import "@fortawesome/fontawesome-svg-core/styles.css"
	fontAwesomeConfig.autoAddCss = false

	import { focus } from "$store/focus.js"
	import { page } from "$store/page.js"
	import { visibility } from "$store/visibility.js"
	import { IsDEV, ListenNUI } from "$utils/nui.js"

	import VisibilityProvider from "$providers/visibility-provider.svelte"

	if (IsDEV()) {
		document.body.style.backgroundColor = "#2C2C2C"
	}

	ListenNUI("visibility", (data) => {
		visibility.set(data)
	})

	ListenNUI("focus", (data) => {
		focus.set(data)
	})

	ListenNUI("page", (data) => {
		page.set(data)
	})
</script>

<VisibilityProvider>
	<main>
		<!-- vite cant resolve aliases in svelte #await directive :( -->
		{#await import(`./lib/views/${$page}.svelte`) then { default: Page }}
			<Page />
		{/await}
	</main>
	<div id="portal"></div>
</VisibilityProvider>
