/* Astra University · Public site interactions */
(function(){
  "use strict";

  // Sticky nav shadow on scroll
  var nav = document.querySelector(".ap-nav");
  if(nav){
    var onScroll = function(){
      if(window.scrollY > 12) nav.classList.add("is-scrolled");
      else nav.classList.remove("is-scrolled");
    };
    document.addEventListener("scroll", onScroll, { passive:true });
    onScroll();
  }

  // Reveal-on-scroll
  var revealEls = document.querySelectorAll(".ap-reveal");
  if("IntersectionObserver" in window && revealEls.length){
    var io = new IntersectionObserver(function(entries){
      entries.forEach(function(entry){
        if(entry.isIntersecting){
          entry.target.classList.add("is-visible");
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.15 });
    revealEls.forEach(function(el){ io.observe(el); });
  } else {
    revealEls.forEach(function(el){ el.classList.add("is-visible"); });
  }

  // Animated counters
  function animateCounter(el){
    var target = parseFloat(el.getAttribute("data-count"));
    var suffix = el.getAttribute("data-suffix") || "";
    var decimals = el.getAttribute("data-decimals") ? parseInt(el.getAttribute("data-decimals"),10) : 0;
    var duration = 1400;
    var start = null;
    function step(ts){
      if(!start) start = ts;
      var progress = Math.min((ts - start) / duration, 1);
      var eased = 1 - Math.pow(1 - progress, 3);
      var value = target * eased;
      el.textContent = (decimals ? value.toFixed(decimals) : Math.round(value).toLocaleString("en-IN")) + suffix;
      if(progress < 1) requestAnimationFrame(step);
    }
    requestAnimationFrame(step);
  }
  var counters = document.querySelectorAll("[data-count]");
  if("IntersectionObserver" in window && counters.length){
    var cio = new IntersectionObserver(function(entries){
      entries.forEach(function(entry){
        if(entry.isIntersecting){
          animateCounter(entry.target);
          cio.unobserve(entry.target);
        }
      });
    }, { threshold: 0.4 });
    counters.forEach(function(el){ cio.observe(el); });
  } else {
    counters.forEach(animateCounter);
  }

  // Filter bar (recruiters / events)
  document.querySelectorAll("[data-filter-group]").forEach(function(group){
    var groupName = group.getAttribute("data-filter-group");
    var items = document.querySelectorAll('[data-filter-item="' + groupName + '"]');
    group.querySelectorAll(".ap-filter-btn").forEach(function(btn){
      btn.addEventListener("click", function(){
        group.querySelectorAll(".ap-filter-btn").forEach(function(b){ b.classList.remove("active"); });
        btn.classList.add("active");
        var val = btn.getAttribute("data-filter-value");
        items.forEach(function(item){
          var cats = (item.getAttribute("data-cats") || "").split(",");
          var show = val === "all" || cats.indexOf(val) !== -1;
          item.style.display = show ? "" : "none";
        });
      });
    });
  });

  // Lightbox for gallery
  var lightbox = document.getElementById("apLightbox");
  if(lightbox){
    var lbImg = lightbox.querySelector("img");
    var lbCap = lightbox.querySelector(".ap-lightbox-cap");
    document.querySelectorAll("[data-lightbox]").forEach(function(item){
      item.addEventListener("click", function(){
        var src = item.getAttribute("data-lightbox");
        var cap = item.getAttribute("data-caption") || "";
        lbImg.setAttribute("src", src);
        if(lbCap) lbCap.textContent = cap;
        lightbox.classList.add("show");
        document.body.style.overflow = "hidden";
      });
    });
    lightbox.addEventListener("click", function(e){
      if(e.target === lightbox || e.target.hasAttribute("data-lightbox-close")){
        lightbox.classList.remove("show");
        document.body.style.overflow = "";
      }
    });
  }

  // Toast helper + form intercept (no backend on public pages)
  window.apToast = function(msg){
    var toast = document.getElementById("apToast");
    if(!toast) return;
    toast.querySelector("span").textContent = msg;
    toast.classList.add("show");
    setTimeout(function(){ toast.classList.remove("show"); }, 3200);
  };
  document.querySelectorAll("form[data-ap-form]").forEach(function(form){
    form.addEventListener("submit", function(e){
      e.preventDefault();
      window.apToast(form.getAttribute("data-ap-form") || "Thank you — we'll be in touch shortly.");
      form.reset();
    });
  });
  // Newsletter widget (plain div, not a <form>, since it lives inside the ASP.NET server form)
  document.querySelectorAll("div[data-ap-form]").forEach(function(box){
    var btn = box.querySelector("button");
    var input = box.querySelector("input");
    if(!btn) return;
    btn.addEventListener("click", function(){
      if(input && !input.checkValidity()){ input.reportValidity(); return; }
      window.apToast(box.getAttribute("data-ap-form") || "Thank you — we'll be in touch shortly.");
      if(input) input.value = "";
    });
  });

  // Active nav link — underline whichever page is currently open
  (function(){
    var current = location.pathname.split("/").pop().toLowerCase();
    if(!current || current === "default.aspx"){ current = "index.aspx"; }
    document.querySelectorAll(".ap-links a").forEach(function(link){
      var href = (link.getAttribute("href") || "").toLowerCase();
      if(href === current){
        link.classList.add("active");
      }
    });
  })();
})();
