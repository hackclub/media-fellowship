<script lang="ts">
	import { onMount } from 'svelte';
	import { carouselImages } from '$lib/carousel';
	import './page.css';

	const stripImages = [...carouselImages, ...carouselImages];

	let topStripA: HTMLDivElement | undefined;
	let topStripB: HTMLDivElement | undefined;
	let bottomStripA: HTMLDivElement | undefined;
	let bottomStripB: HTMLDivElement | undefined;

	let secondPage: HTMLElement | undefined;

	const TOP_SPEED = 75;
	const BOTTOM_SPEED = 75;

	function startTeleportLoop(
		stripA: HTMLDivElement,
		stripB: HTMLDivElement,
		direction: 1 | -1,
		speed: number
	) {
		let frameId = 0;
		let lastTimestamp = 0;
		let stripWidth = 0;
		let positionA = 0;
		let positionB = 0;

		const applyPositions = () => {
			stripA.style.transform = `translate3d(${positionA}px, 0, 0)`;
			stripB.style.transform = `translate3d(${positionB}px, 0, 0)`;
		};

		const resetPositions = () => {
			stripWidth = stripA.getBoundingClientRect().width;
			if (stripWidth <= 0) return;

			if (direction === -1) {
				positionA = 0;
				positionB = stripWidth;
			} else {
				positionA = -stripWidth;
				positionB = 0;
			}

			applyPositions();
		};

		const animate = (timestamp: number) => {
			if (!stripWidth) {
				frameId = requestAnimationFrame(animate);
				return;
			}

			if (!lastTimestamp) {
				lastTimestamp = timestamp;
			}

			const deltaSeconds = (timestamp - lastTimestamp) / 1000;
			lastTimestamp = timestamp;

			const movement = speed * deltaSeconds * direction;
			positionA += movement;
			positionB += movement;

			if (direction === -1) {
				if (positionA <= -stripWidth) positionA = positionB + stripWidth;
				if (positionB <= -stripWidth) positionB = positionA + stripWidth;
			} else {
				if (positionA >= stripWidth) positionA = positionB - stripWidth;
				if (positionB >= stripWidth) positionB = positionA - stripWidth;
			}

			applyPositions();
			frameId = requestAnimationFrame(animate);
		};

		const resizeObserver = new ResizeObserver(() => {
			resetPositions();
			lastTimestamp = 0;
		});

		resizeObserver.observe(stripA);
		window.addEventListener('resize', resetPositions);
		resetPositions();
		frameId = requestAnimationFrame(animate);

		return () => {
			cancelAnimationFrame(frameId);
			resizeObserver.disconnect();
			window.removeEventListener('resize', resetPositions);
		};
	}

	// Carousel animation
	onMount(() => {
		if (!topStripA || !topStripB || !bottomStripA || !bottomStripB) {
			return;
		}

		const stopTop = startTeleportLoop(topStripA, topStripB, -1, TOP_SPEED);
		const stopBottom = startTeleportLoop(bottomStripA, bottomStripB, 1, BOTTOM_SPEED);

		return () => {
			stopTop();
			stopBottom();
		};
	});

	// Fade-in animation (independent of carousel)
	onMount(() => {
		const fadeElements = secondPage?.querySelectorAll('.fade-in');
		if (!fadeElements?.length) return;

		// Set stagger delays via CSS custom property
		fadeElements.forEach((el, i) => {
			(el as HTMLElement).style.setProperty('--fade-delay', `${i * 0.15}s`);
		});

		const observer = new IntersectionObserver(
			(entries) => {
				entries.forEach((entry) => {
					if (entry.isIntersecting) {
						entry.target.classList.add('visible');
						observer.unobserve(entry.target);
					}
				});
			},
			{
				threshold: 0.1,
				rootMargin: '0px 0px -50px 0px'
			}
		);

		fadeElements.forEach((el) => observer.observe(el));

		return () => observer.disconnect();
	});
</script>

<div class="carousel-page">
	<div class="carousel-viewport carousel-top">
		<div class="teleport-strip" bind:this={topStripA}>
			{#each stripImages as src, index (`top-a-${index}`)}
				<div class="image-card">
					<img {src} alt="Carousel item" draggable="false" />
				</div>
			{/each}
		</div>
		<div class="teleport-strip" bind:this={topStripB} aria-hidden="true">
			{#each stripImages as src, index (`top-b-${index}`)}
				<div class="image-card">
					<img {src} alt="Carousel item" draggable="false" />
				</div>
			{/each}
		</div>
	</div>

	<div class="herocontainer">
		<div class="hero">
			<div class="text">
				<h1 id="title">tell our stories.</h1>
				<p id="body">
					Hack Club is hiring 2 teenagers for a paid gap year to create videos, films, and other
					content for Hack Club's social media.
				</p>
			</div>

			<div class="button">
				<a id="applyButton" href="https://example.com">Apply Now (x days remaining)</a>
			</div>
		</div>
	</div>

	<div class="carousel-viewport carousel-bottom">
		<div class="teleport-strip" bind:this={bottomStripA}>
			{#each stripImages as src, index (`bottom-a-${index}`)}
				<div class="image-card">
					<img {src} alt="Carousel item" draggable="false" />
				</div>
			{/each}
		</div>
		<div class="teleport-strip" bind:this={bottomStripB} aria-hidden="true">
			{#each stripImages as src, index (`bottom-b-${index}`)}
				<div class="image-card">
					<img {src} alt="Carousel item" draggable="false" />
				</div>
			{/each}
		</div>
	</div>
</div>

<section class="second-page" bind:this={secondPage}>
	<div class="fade-content">
		<p class="fade-in">We're looking for teenagers who are passionate about storytelling.</p>
		<p class="fade-in">People who see the world differently.</p>
		<p class="fade-in">Who capture moments that matter.</p>
		<p class="fade-in">Who can turn a camera into a window.</p>
		<p class="fade-in">And a story into a movement.</p>
		<p class="fade-in highlight">
			This is your chance to tell the story of a generation of hackers.
		</p>
	</div>
</section>
