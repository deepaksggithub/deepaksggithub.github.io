/* ================================================================
   RIVEDA LLC — SharePoint Online Script
   Simplified version without navigation (SharePoint handles that)
   ================================================================ */

(function () {
    'use strict';

    // ----------------------------------------------------------------
    // Smooth scroll for anchor links
    // ----------------------------------------------------------------
    document.querySelectorAll('.riveda-site a[href^="#"]').forEach(function (anchor) {
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

    // Observe all reveal elements within .riveda-site
    document.querySelectorAll('.riveda-site .reveal').forEach(function (el) {
        revealObserver.observe(el);
    });

    // ----------------------------------------------------------------
    // Contact form — client-side validation
    // ----------------------------------------------------------------
    var contactForm = document.getElementById('rivedaContactForm');

    if (contactForm) {
        contactForm.addEventListener('submit', function (e) {
            e.preventDefault();

            var submitBtn = contactForm.querySelector('button[type="submit"]');
            var originalHTML = submitBtn.innerHTML;

            // Basic field validation
            var name    = contactForm.querySelector('#riveda-name').value.trim();
            var email   = contactForm.querySelector('#riveda-email').value.trim();
            var emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!name) {
                showFormError(submitBtn, originalHTML, 'Please enter your name.');
                return;
            }
            if (!email || !emailRx.test(email)) {
                showFormError(submitBtn, originalHTML, 'Please enter a valid email address.');
                return;
            }

            // Success state (in production, you'd send this to a backend/Microsoft Form/Power Automate flow)
            submitBtn.innerHTML = '<i class="fa-solid fa-circle-check"></i>&nbsp; Message Sent!';
            submitBtn.classList.add('form-submit--success');
            submitBtn.disabled = true;

            // Note: In a real SharePoint environment, you would:
            // 1. Send to a SharePoint list via REST API
            // 2. Trigger a Power Automate flow
            // 3. Send to Microsoft Forms
            // 4. Use a backend API

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
