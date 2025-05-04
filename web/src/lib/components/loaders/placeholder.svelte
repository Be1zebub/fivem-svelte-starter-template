<script>
	export let width = "100%"
	export let height = "100%"
	export let speed = "1.95s"
</script>

<div style="width: {width}; height: {height}; --loader-speed: {speed};"></div>

<style>
	div {
		position: relative;
		overflow: hidden;
	}

	div::before {
		content: "";
		position: absolute;
		top: 0;
		left: 0;
		width: 400%;
		height: 100%;
		background-image: linear-gradient(
			to right,
			rgba(255, 255, 255, 0) 5%,
			rgba(255, 255, 255, 0.1) 20%,
			rgba(255, 255, 255, 0) 60%
		);
		background-repeat: repeat-x;
		background-size: 50% 100%;
		animation: loader-slide var(--loader-speed) linear infinite;
	}

	@keyframes loader-slide {
		from {
			transform: translateX(0);
		}
		to {
			transform: translateX(-50%);
		}
	}
</style>
