/**
 * ASTRA AUTH — shared bootstrap script for all login/register pages
 * (Student, Company, Admin, TPO).
 *
 * Handles iframe embedding check & password visibility eye toggling.
 */
(function () {
    // 1. Check embedded mode
    var embedded = /[?&]embed=1/i.test(window.location.search);
    try { embedded = embedded || window.top !== window.self; } catch (e) { embedded = true; }
    if (embedded) { document.documentElement.className += ' astra-embed'; }

    // 2. Universal Password Visibility Toggle Handler
    function initPasswordEyeToggle() {
        document.addEventListener('click', function (e) {
            var btn = e.target.closest('.ap-auth-eye, .btn-toggle-password, [data-toggle="password"], [data-password-toggle]');
            if (!btn) {
                // Also check if the clicked element itself is an eye icon inside a password input container
                if (e.target.matches('.bi-eye, .bi-eye-slash') && e.target.closest('.ap-auth-input, .input-group, .has-eye')) {
                    var parentSpan = e.target.closest('.ap-auth-input, .input-group, .has-eye');
                    var potentialBtn = parentSpan ? parentSpan.querySelector('.ap-auth-eye, button, a') : null;
                    if (potentialBtn) {
                        btn = potentialBtn;
                    }
                }
            }
            if (!btn) return;

            e.preventDefault();
            e.stopPropagation();

            // Find target input
            var targetId = btn.getAttribute('data-target') || btn.getAttribute('data-bs-target');
            var input = null;

            if (targetId) {
                // Remove '#' if present
                targetId = targetId.replace(/^#/, '');
                input = document.getElementById(targetId);
                if (!input) {
                    input = document.querySelector('[id$="' + targetId + '"]');
                }
            }

            if (!input) {
                // Search relative to parent container
                var container = btn.closest('.ap-auth-input, .input-group, .has-eye, .ap-auth-field, .mb-3, .mb-4') || btn.parentElement;
                if (container) {
                    input = container.querySelector('input[type="password"], input[type="text"]');
                }
            }

            if (!input) return;

            // Toggle input type
            var isPassword = input.type === 'password';
            input.type = isPassword ? 'text' : 'password';

            // Toggle icon inside button
            var icon = btn.querySelector('i, svg');
            if (icon) {
                if (isPassword) {
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }

            btn.setAttribute('aria-label', isPassword ? 'Hide password' : 'Show password');
            btn.setAttribute('title', isPassword ? 'Hide password' : 'Show password');

            // Refocus input and preserve cursor position
            try {
                var len = input.value.length;
                input.focus();
                if (input.setSelectionRange) {
                    input.setSelectionRange(len, len);
                }
            } catch (err) { }
        }, true);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initPasswordEyeToggle);
    } else {
        initPasswordEyeToggle();
    }
})();
