// Astra Redesign — shared interactions for public pages
document.addEventListener('DOMContentLoaded', function () {

  // Sticky nav: solidify on scroll
  var nav = document.querySelector('.ar-nav');
  if (nav) {
    var toggleNav = function () {
      if (window.scrollY > 40) { nav.classList.add('solid'); nav.classList.remove('transparent'); }
      else { nav.classList.remove('solid'); nav.classList.add('transparent'); }
    };
    toggleNav();
    window.addEventListener('scroll', toggleNav, { passive: true });
  }

  // Scroll reveal
  var revealEls = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window && revealEls.length) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); }
      });
    }, { threshold: 0.14 });
    revealEls.forEach(function (el) { io.observe(el); });
  } else {
    revealEls.forEach(function (el) { el.classList.add('in'); });
  }

  // Accordion (policy page)
  document.querySelectorAll('.ar-acc-head').forEach(function (head) {
    head.addEventListener('click', function () {
      var item = head.closest('.ar-acc-item');
      var wasOpen = item.classList.contains('open');
      item.parentElement.querySelectorAll('.ar-acc-item').forEach(function (i) { i.classList.remove('open'); });
      if (!wasOpen) item.classList.add('open');
    });
  });

  // Recruiter industry filter
  var pills = document.querySelectorAll('.ar-filter-pill');
  var recruiterCards = document.querySelectorAll('[data-industry]');
  pills.forEach(function (pill) {
    pill.addEventListener('click', function () {
      pills.forEach(function (p) { p.classList.remove('active'); });
      pill.classList.add('active');
      var f = pill.getAttribute('data-filter');
      recruiterCards.forEach(function (card) {
        if (f === 'all' || card.getAttribute('data-industry') === f) card.style.display = '';
        else card.style.display = 'none';
      });
    });
  });

  // Back to top
  var topBtn = document.querySelector('.ar-fab-btn.top');
  if (topBtn) {
    window.addEventListener('scroll', function () {
      if (window.scrollY > 500) topBtn.classList.add('show'); else topBtn.classList.remove('show');
    }, { passive: true });
    topBtn.addEventListener('click', function () { window.scrollTo({ top: 0, behavior: 'smooth' }); });
  }

  // Contact form — front-end only demo submit
  var contactForm = document.getElementById('arContactForm');
  if (contactForm) {
    contactForm.addEventListener('submit', function (e) {
      e.preventDefault();
      var btn = contactForm.querySelector('button[type="submit"]');
      var original = btn.innerHTML;
      btn.innerHTML = '<i class="bi bi-check2"></i> Message sent';
      btn.disabled = true;
      setTimeout(function () { btn.innerHTML = original; btn.disabled = false; contactForm.reset(); }, 2600);
    });
  }

  // Newsletter — front-end only demo submit
  var nl = document.querySelector('.ar-newsletter');
  if (nl) {
    nl.addEventListener('submit', function (e) {
      e.preventDefault();
      var input = nl.querySelector('input');
      input.placeholder = 'Subscribed ✓';
      input.value = '';
    });
  }
});
