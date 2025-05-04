import { writable } from "svelte/store"

export const focus = writable({
	mouse: false,
	keyboard: false,
})
