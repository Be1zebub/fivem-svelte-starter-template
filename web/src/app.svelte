<script>
	import { config as fontAwesomeConfig } from "@fortawesome/fontawesome-svg-core"
	import "@fortawesome/fontawesome-svg-core/styles.css"
	fontAwesomeConfig.autoAddCss = false

	import { focus } from "$store/focus.js"
	import { visibility } from "$store/visibility.js"
	import { IsDEV, ListenNUI } from "$utils/nui.js"

	import VisibilityProvider from "$providers/visibility-provider.svelte"
	import Example from "$views/example.svelte"

	if (IsDEV()) {
		document.body.style.backgroundColor = "#2C2C2C"
	}

	ListenNUI("visibility", (data) => {
		visibility.set(data)
	})

	ListenNUI("focus", (data) => {
		focus.set(data)
	})
</script>

<VisibilityProvider>
	<main>
		<Example />
	</main>
	<div id="portal"></div>
</VisibilityProvider>
