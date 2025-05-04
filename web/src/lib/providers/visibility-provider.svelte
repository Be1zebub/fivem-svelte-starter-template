<script>
	import { visibility } from "$store/visibility.js"
	import { HideNUI } from "$utils/nui.js"

	const keyHandler = (e) => {
		if (e.code !== "Escape") {
			return
		}

		HideNUI()
	}
</script>

<svelte:window on:keydown={keyHandler} />

{#if $visibility}
	<slot></slot>
{/if}
