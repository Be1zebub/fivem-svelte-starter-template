import { writable } from "svelte/store"

export const visibility = writable(import.meta.env.DEV)
