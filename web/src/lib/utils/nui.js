const enableDebugging = true

///////////////////////////////////////

import { focus } from "$store/focus.js"
import { visibility } from "$store/visibility.js"
import { onDestroy } from "svelte"

///////////////////////////////////////

export function IsBrowser() {
	return !window.invokeNative
}

export function IsDEV() {
	return import.meta.env.DEV
}

///////////////////////////////////////

const eventListeners = new Map()

const eventListener = (event) => {
	const { action, data } = event.data
	const handlers = eventListeners.get(action)

	if (enableDebugging) {
		console.log(
			`got event ${action}, handlers: ${handlers ? handlers.length : 0}, data:`,
			data
		)
	}

	if (handlers) handlers.forEach((handler) => handler(data))
}

window.addEventListener("message", eventListener)

export function ListenNUI(action, handler, bypassLifeCycle = false) {
	const handlers = eventListeners.get(action) || []
	handlers.push(handler)
	eventListeners.set(action, handlers)

	const destroy = () => {
		const handlers = eventListeners.get(action) || []
		eventListeners.set(
			action,
			handlers.filter((h) => h !== handler)
		)
	}

	if (!bypassLifeCycle) {
		onDestroy(destroy)
	}

	return destroy
}

///////////////////////////////////////

export async function FetchNUI(eventName, data = {}, resourceName) {
	if (!resourceName) {
		resourceName = window.GetParentResourceName
			? window.GetParentResourceName()
			: "resource-name"
	}

	if (enableDebugging) {
		console.log(`fetch event ${resourceName}/${eventName}, data:`, data)
	}

	const options = {
		method: "post",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify(data),
	}

	const resp = await fetch(`https://${resourceName}/${eventName}`, options)
	const response = await resp.json()

	if (enableDebugging) {
		console.log(`fetch event ${resourceName}/${eventName}, result:`, response)
	}

	return response
}

///////////////////////////////////////

export async function HideNUI() {
	SetVisibility(false)
	SetFocus(false, false)
}

export async function SetVisibility(visible) {
	visibility.set(visible)
	FetchNUI("visibility", { visibility: visible })
}

export async function SetFocus(mouse = false, keyboard = false) {
	const data = { mouse, keyboard }

	focus.set(data)
	FetchNUI("focus", data)
}
