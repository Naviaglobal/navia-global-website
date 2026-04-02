/**
 * NAVIA GLOBAL — Animaciones GSAP
 * Integración profesional de animaciones para naviaglobal.co
 * Usa: GSAP Core + ScrollTrigger
 */

gsap.registerPlugin(ScrollTrigger);

// ─── UTILIDADES ───────────────────────────────────────────────────────────────

// Configuración global de easing para coherencia visual
const EASE_SMOOTH   = "power3.out";
const EASE_BOUNCE   = "back.out(1.4)";
const EASE_ELEGANT  = "power2.inOut";

// ─── 1. HERO — ENTRADA CINEMATOGRÁFICA ────────────────────────────────────────
// Secuencia ordenada: badge → título → subtítulo → banderas → CTA → trust badges

function initHeroAnimation() {
  const heroContent = document.querySelector(".hero-content");
  if (!heroContent) return;

  const tl = gsap.timeline({ defaults: { ease: EASE_SMOOTH } });

  // Estado inicial: todo invisible antes de animar
  gsap.set(".hero-badge",          { opacity: 0, y: -30 });
  gsap.set(".hero-content h1",     { opacity: 0, y: 60, scale: 0.97 });
  gsap.set(".hero-content > p",    { opacity: 0, y: 40 });
  gsap.set(".hero-flags img",      { opacity: 0, scale: 0.5, y: 20 });
  gsap.set(".hero-cta",            { opacity: 0, y: 30 });
  gsap.set(".trust-badge",         { opacity: 0, y: 25 });

  tl
    .to(".hero-badge",        { opacity: 1, y: 0, duration: 0.6 }, 0.3)
    .to(".hero-content h1",   { opacity: 1, y: 0, scale: 1, duration: 0.85 }, 0.55)
    .to(".hero-content > p",  { opacity: 1, y: 0, duration: 0.7 }, 0.9)
    .to(".hero-flags img",    {
        opacity: 1, scale: 1, y: 0, duration: 0.5,
        stagger: { each: 0.07, from: "start" },
        ease: EASE_BOUNCE
      }, 1.1)
    .to(".hero-cta",          { opacity: 1, y: 0, duration: 0.6, ease: EASE_BOUNCE }, 1.3)
    .to(".trust-badge",       {
        opacity: 1, y: 0, duration: 0.5,
        stagger: 0.12
      }, 1.5);
}

// ─── 2. SECCIÓN DE DESTINOS — CARDS CON SCROLL ────────────────────────────────

function initDestinosAnimation() {
  const cards = document.querySelectorAll(".destino-card");
  if (!cards.length) return;

  // Título y subtítulo de la sección
  gsap.from(".destinos .section-title", {
    opacity: 0, y: 50, duration: 0.8, ease: EASE_SMOOTH,
    scrollTrigger: {
      trigger: ".destinos",
      start: "top 82%",
      once: true
    }
  });

  gsap.from(".destinos .section-subtitle", {
    opacity: 0, y: 30, duration: 0.7, ease: EASE_SMOOTH,
    scrollTrigger: {
      trigger: ".destinos",
      start: "top 78%",
      once: true
    }
  });

  // Cards en lote — aparecen en grupos al hacer scroll
  ScrollTrigger.batch(".destino-card", {
    onEnter: (batch) => {
      gsap.from(batch, {
        opacity: 0,
        y: 70,
        scale: 0.95,
        duration: 0.75,
        ease: EASE_SMOOTH,
        stagger: 0.12,
      });
    },
    start: "top 110%",
    once: true,
  });
}

// ─── 3. ESTADÍSTICAS — CONTADOR ANIMADO ───────────────────────────────────────

function initStatsAnimation() {
  const stats = document.querySelector(".stats");
  if (!stats) return;

  gsap.from(".stat-item", {
    opacity: 0,
    y: 50,
    duration: 0.7,
    ease: EASE_SMOOTH,
    stagger: 0.15,
    scrollTrigger: {
      trigger: ".stats",
      start: "top 85%",
      once: true
    }
  });

  // Animación de conteo para cada número
  document.querySelectorAll(".stat-number").forEach((el) => {
    const text   = el.textContent.trim();
    const suffix = text.replace(/[\d.]/g, ""); // extrae "+", "%", etc.
    const value  = parseFloat(text);
    if (isNaN(value)) return;

    const obj = { val: 0 };

    ScrollTrigger.create({
      trigger: el,
      start: "top 88%",
      once: true,
      onEnter: () => {
        gsap.to(obj, {
          val: value,
          duration: 2,
          ease: "power1.out",
          onUpdate() {
            // Mostrar decimales si el valor original los tiene
            const display = Number.isInteger(value)
              ? Math.round(obj.val)
              : obj.val.toFixed(1);
            el.textContent = display + suffix;
          }
        });
      }
    });
  });
}

// ─── 4. SECCIONES GENERALES — FADE-IN AL HACER SCROLL ─────────────────────────

function initSectionAnimations() {
  // Títulos y subtítulos globales
  gsap.utils.toArray(".section-title:not(.destinos .section-title)").forEach((el) => {
    gsap.from(el, {
      opacity: 0, y: 45, duration: 0.8, ease: EASE_SMOOTH,
      scrollTrigger: { trigger: el, start: "top 85%", once: true }
    });
  });

  gsap.utils.toArray(".section-subtitle:not(.destinos .section-subtitle)").forEach((el) => {
    gsap.from(el, {
      opacity: 0, y: 30, duration: 0.65, ease: EASE_SMOOTH,
      scrollTrigger: { trigger: el, start: "top 85%", once: true }
    });
  });

  // Sección "¿Por qué Navia Global?"
  ScrollTrigger.batch(".por-que-container > *", {
    onEnter: (batch) => {
      gsap.from(batch, {
        opacity: 0, x: -40, duration: 0.7, ease: EASE_SMOOTH, stagger: 0.15
      });
    },
    start: "top 85%",
    once: true,
  });

  // Blog cards
  ScrollTrigger.batch(".blog-card", {
    onEnter: (batch) => {
      gsap.from(batch, {
        opacity: 0, y: 55, scale: 0.97, duration: 0.7, ease: EASE_SMOOTH, stagger: 0.12
      });
    },
    start: "top 88%",
    once: true,
  });
}

// ─── 5. NAVBAR — EFECTO AL HACER SCROLL ───────────────────────────────────────

function initNavbarAnimation() {
  const navbar = document.querySelector(".navbar");
  if (!navbar) return;

  // Entrada suave al cargar: solo deslizar desde arriba, sin fade de opacidad
  // (opacity:0 causaba que el navbar quedara invisible si el tween no progresaba)
  gsap.from(navbar, {
    y: -60, duration: 0.6, ease: EASE_SMOOTH, delay: 0.05
  });

  // Indicador de progreso de lectura en la barra de nav
  const progressBar = document.createElement("div");
  progressBar.style.cssText = `
    position: fixed; top: 0; left: 0; height: 3px; width: 0%;
    background: linear-gradient(90deg, #1ABC9C, #16A085);
    z-index: 9999; border-radius: 0 2px 2px 0;
    pointer-events: none;
  `;
  document.body.appendChild(progressBar);

  ScrollTrigger.create({
    start: "top top",
    end: "bottom bottom",
    onUpdate: (self) => {
      gsap.set(progressBar, { width: (self.progress * 100) + "%" });
    }
  });
}

// ─── 6. BOTONES CTA — PULSO SUAVE ─────────────────────────────────────────────

function initCTAPulse() {
  // Pulso muy sutil en el botón principal para llamar la atención
  const ctaButtons = document.querySelectorAll(".btn-primary, .nav-cta");
  ctaButtons.forEach((btn) => {
    gsap.to(btn, {
      boxShadow: "0 8px 35px rgba(26,188,156,0.55)",
      duration: 1.2,
      repeat: -1,
      yoyo: true,
      ease: "sine.inOut"
    });
  });
}

// ─── 7. SOPORTE REDUCED-MOTION (ACCESIBILIDAD) ────────────────────────────────

function initResponsiveAnimations() {
  gsap.matchMedia().add(
    // Animaciones normales (usuarios sin preferencia de movimiento reducido)
    "(prefers-reduced-motion: no-preference)",
    () => {
      initHeroAnimation();
      initDestinosAnimation();
      initStatsAnimation();
      initSectionAnimations();
      initNavbarAnimation();
      initCTAPulse();
    }
  );

  gsap.matchMedia().add(
    // Versión mínima para usuarios que prefieren menos movimiento
    "(prefers-reduced-motion: reduce)",
    () => {
      // Solo revelar sin mover (fade simple, sin transforms)
      gsap.utils.toArray([
        ".hero-content",
        ".destino-card",
        ".stat-item",
        ".section-title",
        ".blog-card"
      ]).forEach((el) => {
        gsap.from(el, {
          opacity: 0, duration: 0.4,
          scrollTrigger: { trigger: el, start: "top 90%", once: true }
        });
      });
      initStatsAnimation(); // contadores sí están bien para reduced-motion
    }
  );
}

// ─── INICIO ───────────────────────────────────────────────────────────────────
// Script tiene defer → DOM ya está parseado cuando se ejecuta, no hay que esperar DOMContentLoaded

function safeInit() {
  initResponsiveAnimations();
  // Refrescar ScrollTrigger cuando las imágenes terminen de cargar (layout final)
  window.addEventListener("load", () => {
    ScrollTrigger.refresh();
    // Fallback rápido a 900ms — mata tweens atascados y fuerza visibilidad
    setTimeout(() => {
      document.querySelectorAll(
        '.navbar, .hero-cta, .hero-badge, .hero-content h1, .hero-content > p, ' +
        '.hero-flags img, .trust-badge, .stat-item, .section-title, .section-subtitle, ' +
        '.destino-card, .proceso-step, .testimonio-card, .blog-preview-card, ' +
        '.por-que-container > *, .blog-card'
      ).forEach(el => {
        if (window.getComputedStyle(el).opacity === '0') {
          // Matar tweens activos para que GSAP no sobreescriba el fix
          gsap.killTweensOf(el);
          gsap.set(el, { opacity: 1, y: 0, x: 0, scale: 1 });
        }
      });
    }, 900);
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', safeInit);
} else {
  // DOM ya listo (defer ejecutó después de parseo)
  safeInit();
}
