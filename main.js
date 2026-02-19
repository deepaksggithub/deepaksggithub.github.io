/* ================================================================
   RIVEDA LLC — main.js
   ================================================================ */

(function () {
    'use strict';

    // ----------------------------------------------------------------
    // Mobile navigation toggle
    // ----------------------------------------------------------------
    const navToggle = document.getElementById('navToggle');
    const navLinks  = document.getElementById('navLinks');
    const menuIcon  = document.getElementById('menuIcon');

    function closeMenu() {
        navLinks.classList.remove('open');
        menuIcon.className = 'fa-solid fa-bars';
    }

    navToggle.addEventListener('click', function () {
        const isOpen = navLinks.classList.toggle('open');
        menuIcon.className = isOpen ? 'fa-solid fa-xmark' : 'fa-solid fa-bars';
    });

    // Close menu when any nav link is clicked
    navLinks.querySelectorAll('a').forEach(function (link) {
        link.addEventListener('click', closeMenu);
    });

    // Close menu when clicking outside
    document.addEventListener('click', function (e) {
        if (!navToggle.contains(e.target) && !navLinks.contains(e.target)) {
            closeMenu();
        }
    });

    // ----------------------------------------------------------------
    // Header scroll shadow
    // ----------------------------------------------------------------
    var header = document.getElementById('header');

    window.addEventListener('scroll', function () {
        header.classList.toggle('scrolled', window.scrollY > 20);
    }, { passive: true });

    // ----------------------------------------------------------------
    // Smooth scroll for all anchor links
    // ----------------------------------------------------------------
    document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
        anchor.addEventListener('click', function (e) {
            var href = this.getAttribute('href');
            if (href === '#') return;
            var target = document.querySelector(href);
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // ----------------------------------------------------------------
    // Scroll reveal — Intersection Observer
    // ----------------------------------------------------------------
    var revealObserver = new IntersectionObserver(
        function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    revealObserver.unobserve(entry.target);
                }
            });
        },
        { threshold: 0.12, rootMargin: '0px 0px -32px 0px' }
    );

    document.querySelectorAll('.reveal').forEach(function (el) {
        revealObserver.observe(el);
    });

    // ----------------------------------------------------------------
    // Contact form — client-side feedback (no backend)
    // ----------------------------------------------------------------
    var contactForm = document.getElementById('contactForm');

    if (contactForm) {
        contactForm.addEventListener('submit', function (e) {
            e.preventDefault();

            var submitBtn = contactForm.querySelector('button[type="submit"]');
            var originalHTML = submitBtn.innerHTML;

            // Basic field validation
            var name    = contactForm.querySelector('#name').value.trim();
            var email   = contactForm.querySelector('#email').value.trim();
            var emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!name) {
                showFormError(submitBtn, originalHTML, 'Please enter your name.');
                return;
            }
            if (!email || !emailRx.test(email)) {
                showFormError(submitBtn, originalHTML, 'Please enter a valid email address.');
                return;
            }

            // Success state
            submitBtn.innerHTML = '<i class="fa-solid fa-circle-check"></i>&nbsp; Message Sent!';
            submitBtn.classList.add('form-submit--success');
            submitBtn.disabled = true;

            setTimeout(function () {
                submitBtn.innerHTML = originalHTML;
                submitBtn.classList.remove('form-submit--success');
                submitBtn.disabled = false;
                contactForm.reset();
            }, 4000);
        });
    }

    function showFormError(btn, originalHTML, msg) {
        btn.innerHTML = '<i class="fa-solid fa-triangle-exclamation"></i>&nbsp; ' + msg;
        btn.classList.add('form-submit--error');
        setTimeout(function () {
            btn.innerHTML = originalHTML;
            btn.classList.remove('form-submit--error');
        }, 3500);
    }

})();
