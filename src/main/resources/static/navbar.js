// ── SwagSoundShop Navbar Component ──
// Подключай на любой странице: <script src="/navbar.js"></script>
// Добавь в <head>: <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

(function () {

    // ── Стили ──
    const style = document.createElement('style');
    style.textContent = `
        .sss-navbar {
            position: sticky;
            top: 0;
            z-index: 200;
            background: rgba(255,255,255,0.85);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(0,0,0,0.06);
            padding: 0 48px;
            height: 68px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: box-shadow 0.3s;
        }

        .sss-navbar.scrolled { box-shadow: 0 4px 24px rgba(0,0,0,0.08); }

        /* Надпись — fixed поверх всего */
        .sss-logo-fixed {
            position: fixed;
            top: 0;
            left: 48px;
            height: 68px;
            display: flex;
            align-items: center;
            z-index: 400;
            text-decoration: none;
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 700;
            color: #c93138;
            letter-spacing: -0.3px;
            gap: 8px;
            cursor: pointer;
            user-select: none;
        }

        .sss-logo-fixed::before { content: ''; font-size: 18px; }

        /* Пластинка */
        .sss-vinyl {
            position: fixed;
            top: 14px;
            left: 0;
            pointer-events: none;
            z-index: 300;
            transform: translateX(-68%);
            opacity: 0;
            transition: transform 0.5s cubic-bezier(.34,1.2,.64,1), opacity 0.4s ease;
        }

        .sss-vinyl.visible {
            transform: translateX(-28%);
            opacity: 1;
            pointer-events: all;
        }

        .sss-disc {
            width: 240px;
            height: 240px;
            border-radius: 50%;
            flex-shrink: 0;
            background: radial-gradient(circle at center,
                #1a1a1a 0%, #1a1a1a 20%,
            #222 20%, #111 24%,
            #222 28%, #111 32%,
            #222 36%, #111 40%,
            #222 44%, #111 48%,
            #222 48%, #111 50%,
            #222 52%, #111 56%,
            #222 60%, #111 64%,
            #222 68%, #111 72%,
            #222 76%, #111 80%,
            #1a1a1a 80%, #0d0d0d 84%,
            #0d0d0d 84%, #1a1a1a 92%
            );
            box-shadow:
                0 16px 48px rgba(0,0,0,0.6),
                    0 4px 16px rgba(0,0,0,0.4),
                    inset 0 0 0 1px rgba(255,0,0,0.15);
            animation: sss-spin 2.5s linear infinite;
            animation-play-state: paused;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .sss-vinyl.visible .sss-disc { animation-play-state: running; }

        @keyframes sss-spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .sss-center {
            position: absolute;
            width: 84px;
            height: 84px;
            border-radius: 50%;
            background: radial-gradient(circle at 38% 35%, #ff4444, #cc0000, #8b0000);
            box-shadow: 0 2px 12px rgba(200,0,0,0.5);
            z-index: 4;
            animation: sss-spin-rev 2.5s linear infinite;
            animation-play-state: paused;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 2px;
        }

        .sss-vinyl.visible .sss-center { animation-play-state: running; }

        @keyframes sss-spin-rev {
            from { transform: rotate(0deg); }
            to { transform: rotate(-360deg); }
        }

        .sss-hole {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(0,0,0,0.15);
            position: absolute;
            z-index: 5;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.15);
        }

        .sss-links {
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            z-index: 6;
            animation: sss-spin-rev 2.5s linear infinite;
            animation-play-state: paused;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .sss-vinyl.visible .sss-links { animation-play-state: running; }

        .sss-link {
            font-size: 11px;
            font-weight: 800;
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 2px;
            white-space: nowrap;
            padding: 4px 12px;
            border-radius: 20px;
            transition: color 0.2s, background 0.2s;
            text-shadow: 0 1px 2px rgba(255,255,255,0.8);
            font-family: 'DM Sans', sans-serif;
        }

        .sss-link:hover {
            color: #FFFFFF;
            background: rgba(0,0,0,0.15);
        }

        /* Войти / Профиль */
        .sss-login {
            text-decoration: none;
            color: #333;
            font-size: 14px;
            font-weight: 500;
            padding: 9px 18px;
            border-radius: 10px;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 6px;
            border: 1.5px solid #e5e7eb;
            font-family: 'DM Sans', sans-serif;
        }

        .sss-login:hover {
            color: #c93138;
            border-color: #c93138;
            background: rgba(201,54,56,0.04);
        }

        /* Счётчик корзины в пластинке */
        .sss-cart-badge {
            background: #ff4444;
            color: white;
            border-radius: 50%;
            width: 16px;
            height: 16px;
            font-size: 9px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-left: 4px;
            vertical-align: middle;
        }
    `;
    document.head.appendChild(style);

    // ── HTML ──
    const vinyl = document.createElement('div');
    vinyl.className = 'sss-vinyl';
    vinyl.id = 'sss-vinyl';
    vinyl.innerHTML = `
        <div class="sss-disc">
            <div class="sss-links">
                <a href="/index.html" class="sss-link">Главная</a>
                <a href="/catalog.html" class="sss-link">Каталог</a>
                <a href="/cart.html" class="sss-link" style="position:relative;padding-right:24px;">
                    Корзина
                    <span class="sss-cart-badge" id="sss-cart-count" style="position:absolute;right:0;top:50%;transform:translateY(-50%);background:#cc0000;color:white;border-radius:50%;width:16px;height:16px;font-size:9px;font-weight:700;display:flex;align-items:center;justify-content:center;">0</span>
                </a>
            </div>
            <div class="sss-center">
                <span style="font-size:7px;color:rgba(255,255,255,0.9);font-weight:700;letter-spacing:1.5px;margin-top:2px">SSS</span>
            </div>
            <div class="sss-hole"></div>
        </div>
    `;

    const logoFixed = document.createElement('a');
    logoFixed.href = '/index.html';
    logoFixed.className = 'sss-logo-fixed';
    logoFixed.id = 'sss-logo';
    logoFixed.textContent = 'SwagSoundShop';

    const navbar = document.createElement('nav');
    navbar.className = 'sss-navbar';
    navbar.id = 'sss-navbar';
    navbar.innerHTML = `
        <div style="width:220px"></div>
        <a href="/customer-login.html" class="sss-login" id="sss-profile-link">👤 Войти</a>
    `;

    document.body.insertBefore(vinyl, document.body.firstChild);
    document.body.insertBefore(logoFixed, document.body.firstChild);
    document.body.insertBefore(navbar, vinyl.nextSibling);

    // ── Hover логика ──
    const logo = document.getElementById('sss-logo');
    const vinylEl = document.getElementById('sss-vinyl');
    let hideTimer = null;

    function showVinyl() { clearTimeout(hideTimer); vinylEl.classList.add('visible'); }
    function scheduleHide() { hideTimer = setTimeout(() => vinylEl.classList.remove('visible'), 200); }

    logo.addEventListener('mouseenter', showVinyl);
    logo.addEventListener('mouseleave', scheduleHide);
    vinylEl.addEventListener('mouseenter', showVinyl);
    vinylEl.addEventListener('mouseleave', scheduleHide);

    // ── Scroll ──
    window.addEventListener('scroll', () => {
        document.getElementById('sss-navbar').classList.toggle('scrolled', window.scrollY > 10);
    });

    // ── Профиль / Корзина ──
    function updateNavbar() {
        const profileLink = document.getElementById('sss-profile-link');
        if (localStorage.getItem('customer_token')) {
            profileLink.textContent = '👤 Профиль';
            profileLink.href = '/profile.html';
        }
        const cart = JSON.parse(localStorage.getItem('cart') || '[]');
        const count = cart.reduce((s, i) => s + i.quantity, 0);
        const badge = document.getElementById('sss-cart-count');
        if (badge) badge.textContent = count;
    }

    updateNavbar();
    window.addEventListener('storage', updateNavbar);

})();