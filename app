<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Код Безопасности</title>
    
    <script src="https://unpkg.com/@vkontakte/vk-bridge/dist/browser.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { -webkit-tap-highlight-color: transparent; }
        .card-perspective { perspective: 1000px; }
        .card-flipper {
            transition: transform 0.6s cubic-bezier(0.4, 0.2, 0.2, 1);
            transform-style: preserve-3d;
            position: relative;
        }
        .card-flipper.flipped { transform: rotateY(180deg); }
        .card-front, .card-back {
            backface-visibility: hidden;
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
        }
        .card-back { transform: rotateY(180deg); }
        
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-5px); } to { opacity: 1; transform: translateY(0); } }
        .animate-fadeIn { animation: fadeIn 0.3s ease-out forwards; }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 font-sans antialiased overflow-x-hidden selection:bg-blue-100 flex flex-col h-screen">

    <header class="bg-white border-b border-slate-200 sticky top-0 z-40 bg-opacity-90 backdrop-blur-md shrink-0">
        <div class="px-4 py-3 flex items-center justify-between max-w-4xl mx-auto">
            <div class="flex flex-col">
                <div class="flex items-center gap-2">
                    <i class="fa-solid fa-shield-halved text-blue-600 text-xl"></i>
                    <h1 class="font-bold text-lg tracking-tight">Код Безопасности</h1>
                </div>
                <button onclick="openVKUrl('https://vk.ru/im/channels/-239286076')" class="mt-1 bg-blue-50 hover:bg-blue-100 text-blue-600 text-[10px] font-bold px-2.5 py-1 rounded-full w-max transition-colors">
                    <i class="fa-solid fa-plus mr-1"></i>Подписаться
                </button>
            </div>
            <div id="user-profile" class="hidden flex items-center gap-2 bg-slate-50 px-2 py-1 rounded-full border border-slate-100">
                <span id="user-name" class="text-sm font-medium hidden sm:inline text-slate-600"></span>
                <img id="user-avatar" src="" alt="Avatar" class="w-8 h-8 rounded-full shadow-sm">
            </div>
        </div>
    </header>

    <main class="w-full max-w-4xl mx-auto p-4 flex-1 overflow-y-auto relative pb-32">
        
        <section id="tab-city" class="tab-content">
            <h2 class="text-2xl font-extrabold mb-4 flex items-center gap-2"><i class="fa-solid fa-city text-blue-500"></i> В городе</h2>
            <div id="flashcard-widget-city" class="mb-6"></div>
            
            <div class="bg-white p-5 rounded-3xl shadow-sm border border-slate-100 mb-4">
                <h3 class="font-bold text-lg mb-3 text-slate-800">Базовые правила</h3>
                <ul class="space-y-3 text-sm text-slate-600">
                    <li class="flex gap-3"><i class="fa-solid fa-check text-green-500 mt-1"></i><span>Выучите с ребенком его имя, фамилию и телефоны родителей наизусть.</span></li>
                    <li class="flex gap-3"><i class="fa-solid fa-check text-green-500 mt-1"></i><span>Придумайте семейный пароль на случай, если за ребенком придет незнакомец.</span></li>
                </ul>
            </div>
        </section>

        <section id="tab-forest" class="tab-content hidden">
            <h2 class="text-2xl font-extrabold mb-4 flex items-center gap-2"><i class="fa-solid fa-tree text-emerald-500"></i> На природе</h2>
            <div id="flashcard-widget-forest" class="mb-6"></div>
            
            <div class="bg-white p-5 rounded-3xl shadow-sm border border-slate-100 mb-4">
                <h3 class="font-bold text-lg mb-3">Чек-лист в лес</h3>
                <div class="space-y-2" id="forest-checklist">
                    <!-- Заполняется JS -->
                </div>
            </div>
        </section>

        <section id="tab-video" class="tab-content hidden">
            <h2 class="text-2xl font-extrabold mb-4 flex items-center gap-2"><i class="fa-solid fa-circle-play text-red-500"></i> Видеоуроки</h2>
            <div class="grid gap-4 sm:grid-cols-2" id="video-list">
                <!-- Заполняется JS -->
            </div>
        </section>

        <section id="tab-sos" class="tab-content hidden">
            <h2 class="text-2xl font-extrabold mb-4 flex items-center gap-2"><i class="fa-solid fa-triangle-exclamation text-red-500"></i> Экстренно</h2>
            <div id="flashcard-widget-sos" class="mb-6"></div>
            
            <div class="bg-white p-5 rounded-3xl shadow-sm border border-slate-100 mb-6">
                <h3 class="font-bold text-lg mb-3">Поиск отрядов ПСО</h3>
                <input type="text" id="pso-search" placeholder="Введите город (например, Вологда)" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 mb-4 focus:outline-none focus:ring-2 focus:ring-blue-500" onkeyup="filterPSO()">
                <div id="pso-list" class="space-y-3 max-h-60 overflow-y-auto">
                    <!-- Заполняется JS -->
                </div>
                <button onclick="openVKGlobalSearch()" class="mt-4 w-full bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold py-3 rounded-xl text-sm transition-colors active:scale-95">
                    <i class="fa-solid fa-magnifying-glass mr-2"></i> Искать другие города в ВК
                </button>
            </div>

            <button onclick="shareApp()" class="w-full bg-blue-50 hover:bg-blue-100 border border-blue-200 text-blue-700 font-bold py-3.5 rounded-2xl shadow-sm transition-colors active:scale-95 mb-4">
                <i class="fa-solid fa-share-nodes mr-2"></i> Поделиться приложением
            </button>
        </section>

        <section id="tab-support" class="tab-content hidden">
            <h2 class="text-2xl font-extrabold mb-4 flex items-center gap-2"><i class="fa-solid fa-heart text-pink-500"></i> Поддержка</h2>
            <div class="bg-white p-5 rounded-3xl shadow-sm border border-slate-100 mb-4 text-center">
                <div class="w-16 h-16 bg-pink-100 text-pink-500 rounded-full flex items-center justify-center mx-auto mb-4 text-3xl"><i class="fa-solid fa-hand-holding-heart"></i></div>
                <h3 class="font-bold text-lg mb-2">Поддержите проект</h3>
                <p class="text-slate-600 text-sm mb-5">Ваша помощь позволяет нам снимать новые ролики и поддерживать работу приложения.</p>
                <button onclick="openVKUrl('https://vk.com/donut/shishin_85')" class="w-full bg-pink-500 hover:bg-pink-600 text-white font-bold py-3.5 rounded-2xl shadow-sm transition-colors active:scale-95">
                    Оформить VK Donut
                </button>
            </div>
            
            <div class="bg-white p-5 rounded-3xl shadow-sm border border-slate-100 mb-4">
                <h3 class="font-bold text-lg mb-4 text-center">Связь с разработчиком</h3>
                <div class="space-y-3">
                    <button onclick="openVKUrl('https://vk.me/shishin_85')" class="w-full bg-[#0077FF]/10 hover:bg-[#0077FF]/20 text-[#0077FF] font-semibold py-3 rounded-xl flex justify-center items-center gap-2 active:scale-95 transition-all"><i class="fa-brands fa-vk text-lg"></i> ВКонтакте</button>
                    <button onclick="openVKUrl('https://t.me/alexshishin')" class="w-full bg-[#2AABEE]/10 hover:bg-[#2AABEE]/20 text-[#2AABEE] font-semibold py-3 rounded-xl flex justify-center items-center gap-2 active:scale-95 transition-all"><i class="fa-brands fa-telegram text-lg"></i> Telegram</button>
                </div>
            </div>
        </section>
    </main>

    <a href="tel:112" class="fixed bottom-[85px] right-4 z-50 bg-red-600 text-white w-14 h-14 rounded-full flex items-center justify-center shadow-[0_0_15px_rgba(220,38,38,0.5)] active:scale-90 transition-transform">
        <i class="fa-solid fa-phone-volume text-2xl animate-pulse"></i>
    </a>

    <div id="vk-player-modal" class="fixed inset-0 z-[110] bg-black/95 hidden flex-col items-center justify-center opacity-0 transition-opacity duration-300">
        <button onclick="closeVideo()" class="absolute top-6 right-4 sm:top-8 sm:right-8 text-white/70 hover:text-white w-12 h-12 flex items-center justify-center bg-white/10 rounded-full backdrop-blur-sm transition-all active:scale-95 z-[120]">
            <i class="fa-solid fa-xmark text-2xl"></i>
        </button>
        <div class="w-full max-w-4xl px-2 sm:px-6 relative z-[115]">
            <div class="relative w-full pb-[56.25%] rounded-2xl overflow-hidden shadow-2xl bg-black">
                <iframe id="vk-iframe" src="" class="absolute top-0 left-0 w-full h-full" allow="autoplay; encrypted-media; fullscreen; picture-in-picture;" frameborder="0" allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <nav class="fixed bottom-0 w-full bg-white border-t border-slate-200 z-40">
        <div class="flex justify-around items-center h-16 max-w-4xl mx-auto px-2">
            <button onclick="switchTab('city')" class="tab-btn flex flex-col items-center justify-center w-full h-full text-blue-600 transition-colors" data-target="city"><i class="fa-solid fa-city text-xl mb-1"></i><span class="text-[10px] font-semibold">Город</span></button>
            <button onclick="switchTab('forest')" class="tab-btn flex flex-col items-center justify-center w-full h-full text-slate-400 hover:text-emerald-600 transition-colors" data-target="forest"><i class="fa-solid fa-tree text-xl mb-1"></i><span class="text-[10px] font-semibold">Лес</span></button>
            <button onclick="switchTab('video')" class="tab-btn flex flex-col items-center justify-center w-full h-full text-slate-400 hover:text-red-600 transition-colors" data-target="video"><i class="fa-solid fa-circle-play text-xl mb-1"></i><span class="text-[10px] font-semibold">Видео</span></button>
            <button onclick="switchTab('sos')" class="tab-btn flex flex-col items-center justify-center w-full h-full text-slate-400 hover:text-red-600 transition-colors" data-target="sos"><i class="fa-solid fa-triangle-exclamation text-xl mb-1"></i><span class="text-[10px] font-semibold">SOS</span></button>
            <button onclick="switchTab('support')" class="tab-btn flex flex-col items-center justify-center w-full h-full text-slate-400 hover:text-pink-600 transition-colors" data-target="support"><i class="fa-solid fa-heart text-xl mb-1"></i><span class="text-[10px] font-semibold">Донат</span></button>
        </div>
    </nav>

    <script>
        const THEMES = {
            city: { bgLight: 'bg-blue-50', text: 'text-blue-600', border: 'border-blue-100', bgMain: 'bg-blue-500', hover: 'hover:bg-blue-600', icon: 'fa-city' },
            forest: { bgLight: 'bg-emerald-50', text: 'text-emerald-600', border: 'border-emerald-100', bgMain: 'bg-emerald-500', hover: 'hover:bg-emerald-600', icon: 'fa-tree' },
            sos: { bgLight: 'bg-red-50', text: 'text-red-600', border: 'border-red-100', bgMain: 'bg-red-500', hover: 'hover:bg-red-600', icon: 'fa-triangle-exclamation' }
        };

        const ALL_FLASHCARDS = [
            { category: 'city', front: "Правило «Стой, где стоишь»", back: "Основное правило: оставаться на месте и ждать, пока тебя найдут.", hint: "Главное действие при потере родителей." },
            { category: 'city', front: "Семейный пароль", back: "Кодовое слово, подтверждающее, что незнакомец пришел от родителей.", hint: "Проверка для чужого человека." },
            { category: 'city', front: "Безопасные взрослые", back: "Полицейские, охранники, кассиры магазинов и женщины с детьми.", hint: "К кому безопасно обратиться за помощью." },
            { category: 'city', front: "Правило «Три О»", back: "Остановись, Оглядись, Окликни — алгоритм действий, если потерял родителей.", hint: "Первые шаги при потере." },
            { category: 'city', front: "Защита окон", back: "Специальные замки-блокаторы. Москитные сетки НЕ защищают!", hint: "Как предотвратить падение из окна." },
            { category: 'city', front: "Общение с незнакомцами", back: "Не подходить ближе вытянутой руки, не садиться в машины, ничего не брать.", hint: "Безопасная дистанция." },
            { category: 'city', front: "Громкий крик", back: "Кричать: «Я его не знаю! Это не мой папа / мама!»", hint: "Если уводят силой." },
            { category: 'city', front: "Островки безопасности", back: "Специальные зоны в сетевых магазинах для помощи потерявшимся.", hint: "Ищи оранжевые знаки." },
            { category: 'city', front: "Поведение в толпе", back: "Согнуть руки в локтях и прижать к груди, двигаться по течению, избегать стен.", hint: "Защита грудной клетки." },
            { category: 'city', front: "Пожар в квартире", back: "Немедленно выбегать, не прятаться, дышать через влажную ткань, вызвать 112.", hint: "Главное правило эвакуации." },
            { category: 'city', front: "Трекеры для детей", back: "Смарт-часы должны быть заряжены и включены.", hint: "Электронный контроль." },
            { category: 'forest', front: "Обними дерево", back: "Если потерялся в лесу — обними ближайшее дерево, стой на месте и шуми.", hint: "Что делать в лесу в первую очередь." },
            { category: 'forest', front: "Цвет одежды в лес", back: "Яркая (красная, желтая, оранжевая). Камуфляж запрещен!", hint: "Как облегчить работу спасателям." },
            { category: 'forest', front: "Прибор в лесу", back: "Громкий свисток на шее. Свистеть проще, чем долго кричать.", hint: "Экономит силы." },
            { category: 'forest', front: "Встреча с собаками", back: "Не бежать, не смотреть в глаза, медленно отступать спиной к укрытию.", hint: "Как не спровоцировать стаю." },
            { category: 'forest', front: "Нарукавники", back: "Опасны: могут сдуться или перевернуть ребенка головой в воду.", hint: "Почему это не спас-средство." },
            { category: 'forest', front: "Спасательный жилет", back: "Должен быть сертифицированным, по размеру и с паховым ремнем.", hint: "Надежное средство на воде." },
            { category: 'forest', front: "Укус змеи", back: "Обездвижить конечность, пить много воды, вызвать 112.", hint: "Первая помощь." },
            { category: 'forest', front: "Уж или гадюка?", back: "У ужа — желтые пятна. У гадюки — зигзаг на спине и вертикальный зрачок.", hint: "Как отличить ядовитую." },
            { category: 'forest', front: "Лед водоема", back: "Не выходить на лед тоньше 10 см, избегать темных пятен.", hint: "Толщина безопасного льда." },
            { category: 'forest', front: "Вода в лесу", back: "Пить только принесенную воду. Из луж пить запрещено!", hint: "Профилактика отравлений." },
            { category: 'sos', front: "Номер спасения", back: "112 — бесплатный номер. Работает без SIM-карты.", hint: "Единый телефон экстренных служб." },
            { category: 'sos', front: "Что сказать 112", back: "Что случилось, точный адрес, ФИО, возраст, приметы.", hint: "Алгоритм разговора." },
            { category: 'sos', front: "ПСО", back: "Добровольческий Поисково-спасательный отряд (волонтеры).", hint: "Помощники полиции и МЧС." },
            { category: 'sos', front: "Телефон", back: "Заряд 100%, включена геолокация, положительный баланс.", hint: "Правило связи перед выходом." }
        ];

        const vkVideos = {
            'Дети и животные': 'https://vk.com/video_ext.php?oid=16426067&id=456240849&hash=xxxx&t=6m33s',
            'Безопасность на воде': 'https://vk.com/video_ext.php?oid=16426067&id=456240845&hash=xxxx&t=6m32s',
            'Безопасное окно': 'https://vk.com/video_ext.php?oid=16426067&id=456240832&hash=xxxx&t=2m18s',
            'Встреча со змеей': 'https://vk.com/video_ext.php?oid=16426067&id=456240835&hash=xxxx&t=2m22s'
        };

        const psoDatabase = [
            { name: "ПСО Ты не один", city: "Вологодская область", phone: "89115056898", vk: "https://vk.com/pso_ty_ne_odin" },
            { name: "ПСО ЮК-Спас", city: "Вологодская область", phone: "89211238880", vk: "https://vk.com/ukspas" },
            { name: "ПСО Азимут", city: "Вологодская область", phone: "89115183366", vk: "https://vk.com/pso_azimut" },
            { name: "ПСО Тотьма-Спас", city: "Вологодская область", phone: "89210663189", vk: "https://vk.com/totma_spas" },
            { name: "ПСО Устюг-Спас", city: "Вологодская область", phone: "89215329864", vk: "https://vk.com/ustug_spas" },
            { name: "ПСО ЛизаАлерт", city: "Федеральный отряд", phone: "88007005452", vk: "https://vk.com/lizaalert_real" }
        ];

        const widgetStates = {
            city: { currentIndex: 0, isFlipped: false, showHint: false },
            forest: { currentIndex: 0, isFlipped: false, showHint: false },
            sos: { currentIndex: 0, isFlipped: false, showHint: false }
        };

        async function initApp() {
            try {
                await vkBridge.send('VKWebAppInit');
            } catch (e) {
                console.error('VK Bridge init error', e);
            }

            try {
                const user = await vkBridge.send('VKWebAppGetUserInfo');
                if (user && user.first_name) {
                    document.getElementById('user-name').textContent = user.first_name;
                    document.getElementById('user-avatar').src = user.photo_100;
                    document.getElementById('user-profile').classList.remove('hidden');
                }
            } catch(e) { }

            ['city', 'forest', 'sos'].forEach(renderFlashcardWidget);

            const videoContainer = document.getElementById('video-list');
            for (const [title, link] of Object.entries(vkVideos)) {
                videoContainer.innerHTML += `
                    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden group cursor-pointer" onclick="openVideo('${link}')">
                        <div class="relative pb-[56.25%] bg-slate-200">
                            <div class="absolute inset-0 flex items-center justify-center bg-slate-800/20 group-hover:bg-slate-800/40 transition-colors">
                                <div class="w-12 h-12 bg-white/90 rounded-full flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform">
                                    <i class="fa-solid fa-play text-red-500 text-xl ml-1"></i>
                                </div>
                            </div>
                        </div>
                        <div class="p-4">
                            <h3 class="font-bold text-slate-800 text-sm mb-1 group-hover:text-red-500 transition-colors">${title}</h3>
                            <p class="text-xs text-slate-500">Нажмите, чтобы посмотреть видеоурок</p>
                        </div>
                    </div>`;
            }

            filterPSO();

            const checklistItems = ['Полностью заряженный телефон', 'Свисток на шею', 'Яркая одежда', 'Вода и перекус'];
            const checklistContainer = document.getElementById('forest-checklist');
            checklistItems.forEach(item => {
                checklistContainer.innerHTML += `
                    <label class="flex items-center gap-3 p-3 bg-slate-50 rounded-xl cursor-pointer hover:bg-slate-100 transition-colors border border-slate-100">
                        <input type="checkbox" class="w-5 h-5 text-emerald-500 rounded border-slate-300 focus:ring-emerald-500" onchange="triggerTaptic()">
                        <span class="text-sm font-medium text-slate-700">${item}</span>
                    </label>`;
            });
        }

        function switchTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
            document.getElementById('tab-' + tabId).classList.remove('hidden');
            
            document.querySelectorAll('.tab-btn').forEach(btn => {
                const isActive = btn.getAttribute('data-target') === tabId;
                let baseColor = 'slate';
                if(btn.className.includes('hover:text-blue') || tabId === 'city') baseColor = 'blue';
                if(btn.className.includes('hover:text-emerald') || tabId === 'forest') baseColor = 'emerald';
                if(btn.className.includes('hover:text-red') || tabId === 'video' || tabId === 'sos') baseColor = 'red';
                if(btn.className.includes('hover:text-pink') || tabId === 'support') baseColor = 'pink';
                
                btn.className = `tab-btn flex flex-col items-center justify-center w-full h-full transition-colors ${isActive ? 'text-' + baseColor + '-600' : 'text-slate-400 hover:text-' + baseColor + '-600'}`;
            });
            triggerTaptic();
            window.scrollTo(0,0);
        }

        function triggerTaptic() {
            try { vkBridge.send('VKWebAppTapticSelectionChanged'); } catch(e) {}
        }

        function renderFlashcardWidget(category) {
            const container = document.getElementById('flashcard-widget-' + category);
            if (!container) return;
            
            const cards = ALL_FLASHCARDS.filter(c => c.category === category);
            if (cards.length === 0) return;
            
            const state = widgetStates[category];
            const currentCard = cards[state.currentIndex];
            const t = THEMES[category] || THEMES.city;

            container.innerHTML = `
                <div class="bg-white p-4 rounded-3xl shadow-sm border border-slate-100">
                    <div class="flex items-center justify-between mb-3">
                        <span class="text-xs font-bold uppercase tracking-wider ${t.text} ${t.bgLight} px-3 py-1 rounded-full flex items-center gap-1.5"><i class="fa-solid ${t.icon}"></i> Карточки</span>
                        <span class="text-xs font-bold text-slate-400">${state.currentIndex + 1} / ${cards.length}</span>
                    </div>
                    <div class="card-perspective h-48 w-full cursor-pointer select-none" onclick="toggleCardFlip('${category}')">
                        <div id="card-flipper-${category}" class="card-flipper w-full h-full rounded-2xl shadow-sm border border-slate-200 ${state.isFlipped ? 'flipped' : ''}">
                            <div class="card-front bg-gradient-to-br from-slate-50 to-white p-5 rounded-2xl flex flex-col justify-between border ${t.border}">
                                <div class="text-center my-auto px-2"><h3 class="font-extrabold text-slate-800 text-lg leading-snug">${currentCard.front}</h3></div>
                                <div class="text-center text-xs ${t.text} font-semibold"><i class="fa-solid fa-hand-pointer text-xs"></i> Нажмите, чтобы узнать ответ</div>
                            </div>
                            <div class="card-back bg-slate-800 text-white p-5 rounded-2xl flex flex-col justify-between border border-slate-700">
                                <div class="text-center my-auto px-2"><p class="text-xs sm:text-sm text-slate-200 leading-relaxed font-medium">${currentCard.back}</p></div>
                            </div>
                        </div>
                    </div>
                    ${state.showHint ? `<div class="mt-3 bg-amber-50 border border-amber-200 text-amber-800 p-3 rounded-xl text-xs flex items-start gap-2 animate-fadeIn"><i class="fa-solid fa-lightbulb text-amber-500 mt-0.5 text-sm shrink-0"></i><div><span class="font-bold">Подсказка:</span> ${currentCard.hint}</div></div>` : ''}
                    <div class="flex items-center justify-between gap-2 mt-4">
                        <button onclick="prevCard('${category}')" class="flex-1 bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold py-2 px-3 rounded-xl text-xs transition-colors active:scale-95"><i class="fa-solid fa-chevron-left"></i> Назад</button>
                        <button onclick="toggleHint('${category}')" class="bg-amber-100 hover:bg-amber-200 text-amber-700 font-bold p-2.5 rounded-xl text-xs transition-colors active:scale-95"><i class="fa-solid fa-lightbulb"></i></button>
                        <button onclick="nextCard('${category}')" class="flex-1 ${t.bgMain} ${t.hover} text-white font-semibold py-2 px-3 rounded-xl text-xs transition-colors active:scale-95">Далее <i class="fa-solid fa-chevron-right"></i></button>
                    </div>
                </div>`;
        }

        function toggleCardFlip(category) { 
            widgetStates[category].isFlipped = !widgetStates[category].isFlipped; 
            const flipper = document.getElementById('card-flipper-' + category);
            if (widgetStates[category].isFlipped) flipper.classList.add('flipped');
            else flipper.classList.remove('flipped');
            triggerTaptic(); 
        }
        function toggleHint(category) { widgetStates[category].showHint = !widgetStates[category].showHint; renderFlashcardWidget(category); triggerTaptic(); }
        function nextCard(category) { 
            const cards = ALL_FLASHCARDS.filter(c => c.category === category);
            const s = widgetStates[category]; s.isFlipped = false; s.showHint = false; s.currentIndex = (s.currentIndex + 1) % cards.length; renderFlashcardWidget(category); triggerTaptic(); 
        }
        function prevCard(category) { 
            const cards = ALL_FLASHCARDS.filter(c => c.category === category);
            const s = widgetStates[category]; s.isFlipped = false; s.showHint = false; s.currentIndex = (s.currentIndex - 1 + cards.length) % cards.length; renderFlashcardWidget(category); triggerTaptic(); 
        }

        function openVideo(url) {
            const modal = document.getElementById('vk-player-modal');
            const iframe = document.getElementById('vk-iframe');
            iframe.src = url;
            modal.classList.remove('hidden');
            setTimeout(() => modal.classList.remove('opacity-0'), 10);
        }

        function closeVideo() {
            const modal = document.getElementById('vk-player-modal');
            const iframe = document.getElementById('vk-iframe');
            modal.classList.add('opacity-0');
            setTimeout(() => { modal.classList.add('hidden'); iframe.src = ''; }, 300);
        }

        function openVKUrl(url) {
            try {
                if (window.vkBridge) {
                    vkBridge.send('VKWebAppOpenUrl', { url: url });
                } else {
                    window.open(url, '_blank');
                }
            } catch(e) { window.open(url, '_blank'); }
        }

        function openVKGlobalSearch() {
            const query = document.getElementById('pso-search').value;
            const searchUrl = "https://vk.com/search?c[q]=" + query + "&c[section]=communities";
            openVKUrl(searchUrl);
        }

        function filterPSO() {
            const query = document.getElementById('pso-search').value.toLowerCase();
            const container = document.getElementById('pso-list');
            container.innerHTML = '';
            
            const filtered = psoDatabase.filter(pso => pso.name.toLowerCase().includes(query) || pso.city.toLowerCase().includes(query));
            
            if (filtered.length === 0) {
                container.innerHTML = '<div class="text-center py-4 text-slate-500 text-sm">В базе нет отрядов по этому запросу. Попробуйте глобальный поиск ВКонтакте.</div>';
                return;
            }

            filtered.forEach(pso => {
                container.innerHTML += `
                    <div class="bg-white p-3 rounded-xl border border-slate-100 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                        <div>
                            <h4 class="font-bold text-slate-800 text-sm">${pso.name}</h4>
                            <p class="text-xs text-slate-500"><i class="fa-solid fa-location-dot mr-1"></i>${pso.city}</p>
                        </div>
                        <div class="flex gap-2">
                            <a href="tel:${pso.phone}" class="flex-1 sm:flex-none bg-green-100 hover:bg-green-200 text-green-700 px-3 py-2 rounded-lg text-xs font-bold text-center transition-colors"><i class="fa-solid fa-phone"></i> Вызов</a>
                            <button onclick="openVKUrl('${pso.vk}')" class="flex-1 sm:flex-none bg-blue-100 hover:bg-blue-200 text-blue-700 px-3 py-2 rounded-lg text-xs font-bold text-center transition-colors"><i class="fa-brands fa-vk text-sm"></i> Группа</button>
                        </div>
                    </div>`;
            });
        }

        function shareApp() {
            let shareLink = "https://vk.com/app51740000"; 
            const appIdMatch = window.location.search.match(/vk_app_id=([^&]*)/);
            if (appIdMatch && appIdMatch[1]) {
                shareLink = `https://vk.com/app${appIdMatch[1]}`;
            }

            try {
                vkBridge.send('VKWebAppShare', { link: shareLink });
            } catch(e) {}
        }

        window.addEventListener('DOMContentLoaded', initApp);
    </script>
</body>
</html>
