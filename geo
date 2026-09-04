<!doctype html>
<html lang="ru">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GeoClimate South | Пассивный микроклимат</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <style>
        :root {
            color-scheme: dark;
        }

        body {
            font-family: Inter, ui-sans-serif, system-ui, sans-serif;
            background: #071412;
            background-image: radial-gradient(circle at 80% 0%, rgba(16, 185, 129, .13), transparent 32rem), linear-gradient(135deg, #071412, #0d1b25 55%, #10221c);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
            animation: rise .35s ease both;
        }

        @keyframes rise {
            from {
                opacity: 0;
                transform: translateY(8px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .panel {
            background: rgba(15, 23, 42, .82);
            border: 1px solid rgba(52, 211, 153, .16);
            box-shadow: 0 18px 50px rgba(0, 0, 0, .18);
        }

        .metric {
            border-left: 3px solid #34d399;
            background: rgba(15, 23, 42, .72);
        }

        .tab-btn.active {
            color: #6ee7b7;
            background: rgba(16, 185, 129, .15);
        }

        input[type=range] {
            accent-color: #34d399;
        }

        #map {
            height: 560px;
            border-radius: 14px;
            z-index: 1;
        }

        .leaflet-popup-content-wrapper,
        .leaflet-popup-tip {
            background: #e2e8f0;
            color: #0f172a;
        }

        .number {
            font-variant-numeric: tabular-nums;
        }
    </style>
</head>

<body class="min-h-screen text-slate-200">
    <header class="sticky top-0 z-50 border-b border-emerald-400/15 bg-slate-950/90 backdrop-blur-xl">
        <div class="mx-auto flex max-w-7xl flex-wrap items-center justify-between gap-3 px-4 py-3">
            <div class="flex items-center gap-3">
                <div class="grid h-10 w-10 place-items-center rounded-xl bg-emerald-400/15 text-xl text-emerald-300">◈
                </div>
                <div>
                    <div class="font-black tracking-tight text-emerald-300">GeoClimate South</div>
                </div>
            </div>
            <nav class="flex max-w-full gap-1 overflow-x-auto text-sm" aria-label="Разделы"><button
                    class="tab-btn active whitespace-nowrap rounded-lg px-3 py-2" data-target="tab-a">🌾
                    Агро</button><button class="tab-btn whitespace-nowrap rounded-lg px-3 py-2 text-slate-400"
                    data-target="tab-b">🏡 Дом</button><button
                    class="tab-btn whitespace-nowrap rounded-lg px-3 py-2 text-slate-400" data-target="tab-c">🏭
                    Эко-IT</button><button class="tab-btn whitespace-nowrap rounded-lg px-3 py-2 text-slate-400"
                    data-target="tab-d">🗺️ Экспедиция</button><button
                    class="tab-btn whitespace-nowrap rounded-lg px-3 py-2 text-slate-400" data-target="tab-ai">🤖
                    ИИ</button></nav>
        </div>
    </header>
    <main class="mx-auto max-w-7xl px-4 py-8">
        <section class="mb-8 grid gap-6 lg:grid-cols-[1.35fr_.65fr]">
            <div>
                <p class="mb-3 text-xs font-bold uppercase tracking-[.25em] text-emerald-300">Полевой атлас · инженерная
                    модель</p>
                <h1 class="max-w-3xl text-4xl font-black tracking-tight text-white md:text-6xl">Климат можно <span
                        class="text-emerald-300">проектировать.</span></h1>
                <p class="mt-4 max-w-2xl text-slate-400">Интерактивная платформа для агро-сектора, пассивного
                    строительства и сухого охлаждения</p>
            </div>
            <div class="panel rounded-2xl p-5">
                <div class="mb-4 flex items-center justify-between"><span class="text-sm text-slate-400">Сводка
                        экспедиции</span><span
                        class="rounded-full bg-emerald-400/10 px-2 py-1 text-xs text-emerald-300">LIVE MODEL</span>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <div class="text-3xl font-black text-white">5</div>
                        <div class="text-xs text-slate-500">точек измерений</div>
                    </div>
                    <div>
                        <div class="text-3xl font-black text-cyan-300">26.5°</div>
                        <div class="text-xs text-slate-500">макс. ΔT в данных</div>
                    </div>
                </div>
            </div>
        </section>
        <section id="tab-a" class="tab-content active">
            <div class="mb-5 flex flex-wrap items-end justify-between gap-3">
                <div>
                    <p class="text-xs uppercase tracking-widest text-emerald-400">Раздел A · для фермеров</p>
                    <h2 class="text-2xl font-bold text-white">Подземный склад</h2>
                </div>
                <div class="text-xs text-slate-500">Фурье: α = 0.043 м²/сутки · τ = 365 дней</div>
            </div>
            <div class="grid gap-5 lg:grid-cols-[.75fr_1.25fr]">
                <div class="panel rounded-2xl p-5">
                    <h3 class="mb-5 font-bold text-white">Параметры проекта</h3><label
                        class="mb-2 block text-sm text-slate-400">Культура</label><select id="crop"
                        class="mb-6 w-full rounded-lg border border-slate-700 bg-slate-950 p-3">
                        <option value="apples">Яблоки / груши</option>
                        <option value="grapes">Виноград</option>
                        <option value="tomatoes">Томаты / перцы</option>
                        <option value="potatoes">Картофель / лук</option>
                    </select><label class="flex justify-between text-sm text-slate-400">Урожай <b id="tonnageValue"
                            class="text-emerald-300">50 т</b></label><input id="tonnage" class="mb-6 mt-3 w-full"
                        type="range" min="10" max="500" value="50"><label
                        class="flex justify-between text-sm text-slate-400">Глубина <b id="depthValue"
                            class="text-emerald-300">3.0 м</b></label><input id="depth" class="mt-3 w-full" type="range"
                        min="1" max="10" step=".1" value="3">
                    <div class="mt-6 rounded-xl bg-emerald-400/10 p-4 text-sm text-emerald-200">Модель учитывает
                        затухание годовой температурной волны в глинистом грунте и объём урожая.</div>
                </div>
                <div class="grid gap-5 md:grid-cols-2">
                    <div class="panel rounded-2xl p-5 md:col-span-2">
                        <div class="grid gap-4 sm:grid-cols-4">
                            <div class="metric rounded-xl p-4">
                                <div class="text-xs text-slate-500">Температура</div>
                                <div id="cropTemp" class="number mt-2 text-2xl font-black text-emerald-300">23.9 °C
                                </div>
                            </div>
                            <div class="metric rounded-xl p-4">
                                <div class="text-xs text-slate-500">Панели</div>
                                <div id="panelArea" class="number mt-2 text-2xl font-black text-cyan-300">15 м²</div>
                            </div>
                            <div class="metric rounded-xl p-4">
                                <div class="text-xs text-slate-500">Сохранение массы</div>
                                <div id="cropSave" class="number mt-2 text-2xl font-black text-amber-300">78%</div>
                            </div>
                            <div class="metric rounded-xl p-4">
                                <div class="text-xs text-slate-500">Экономия / год</div>
                                <div id="cropEconomy" class="number mt-2 text-xl font-black text-white">900 000 ₸</div>
                            </div>
                        </div>
                    </div>
                    <div class="panel overflow-hidden rounded-2xl md:col-span-2">
                        <div class="border-b border-slate-700 p-4">
                            <h3 class="font-bold text-white">Оптимальные режимы хранения</h3>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left text-sm">
                                <thead class="bg-slate-950/60 text-xs uppercase text-slate-500">
                                    <tr>
                                        <th class="p-3">Культура</th>
                                        <th class="p-3">Температура</th>
                                        <th class="p-3">RH</th>
                                        <th class="p-3">Срок</th>
                                    </tr>
                                </thead>
                                <tbody id="storageTable" class="divide-y divide-slate-800"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section id="tab-b" class="tab-content">
            <div class="mb-5">
                <p class="text-xs uppercase tracking-widest text-emerald-400">Раздел B · для жителей</p>
                <h2 class="text-2xl font-bold text-white">Конструктор пассивного дома</h2>
            </div>
            <div class="grid gap-5 lg:grid-cols-[.7fr_1.3fr]">
                <div class="panel rounded-2xl p-5">
                    <h3 class="mb-5 font-bold text-white">Входные параметры</h3><label
                        class="flex justify-between text-sm text-slate-400">Площадь <b id="areaValue"
                            class="text-emerald-300">120 м²</b></label><input id="area" class="mb-6 mt-3 w-full"
                        type="range" min="50" max="300" value="120"><label
                        class="flex justify-between text-sm text-slate-400">Толщина стены <b id="wallValue"
                            class="text-emerald-300">0.5 м</b></label><input id="wall" class="mb-6 mt-3 w-full"
                        type="range" min=".2" max="1.5" step=".1" value=".5"><label
                        class="flex justify-between text-sm text-slate-400">Высота купола <b id="domeValue"
                            class="text-emerald-300">4.0 м</b></label><input id="dome" class="mt-3 w-full" type="range"
                        min="2" max="15" step=".5" value="4">
                    <div class="mt-6 border-t border-slate-700 pt-4 text-xs text-slate-500">Расчёт тяги: v =
                        √(2gh·ΔT/T), ρ воздуха = 1.2 кг/м³.</div>
                </div>
                <div class="grid gap-5 sm:grid-cols-2">
                    <div class="metric rounded-2xl p-5">
                        <div class="text-xs uppercase text-emerald-300">Модуль погреба</div>
                        <div id="cellarDepth" class="mt-3 text-3xl font-black text-white">2.4 м</div>
                        <p class="mt-2 text-sm text-slate-400">Оценочная глубина стабильных +18 °C.</p>
                    </div>
                    <div class="metric rounded-2xl border-cyan-400/40 p-5">
                        <div class="text-xs uppercase text-cyan-300">Купол Яссауи</div>
                        <div id="draftSpeed" class="mt-3 text-3xl font-black text-white">1.8 м/с</div>
                        <p class="mt-2 text-sm text-slate-400">Естественная вытяжная тяга.</p>
                    </div>
                    <div class="metric rounded-2xl border-amber-400/40 p-5">
                        <div class="text-xs uppercase text-amber-300">Охлаждение яруса</div>
                        <div id="tempDrop" class="mt-3 text-3xl font-black text-white">5.2 °C</div>
                        <p class="mt-2 text-sm text-slate-400">Целевой диапазон снижения 5–8 °C.</p>
                    </div>
                    <div class="metric rounded-2xl border-green-400/40 p-5">
                        <div class="text-xs uppercase text-green-300">Палисадник Аксу</div>
                        <div id="treeCooling" class="mt-3 text-3xl font-black text-white">−3.5 °C</div>
                        <p class="mt-2 text-sm text-slate-400">Охлаждение притока при 3–5 деревьях.</p>
                    </div>
                </div>
            </div>
        </section>
        <section id="tab-c" class="tab-content">
            <div class="mb-5">
                <p class="text-xs uppercase tracking-widest text-emerald-400">Раздел C · для бизнеса</p>
                <h2 class="text-2xl font-bold text-white">Zero-Water Free-Cooling</h2>
            </div>
            <div class="panel mb-5 rounded-2xl p-5"><label
                    class="flex justify-between text-sm text-slate-400">IT-нагрузка <b id="loadValue"
                        class="text-emerald-300">1 000 кВт</b></label><input id="load" class="mt-3 w-full" type="range"
                    min="100" max="10000" step="100" value="1000"></div>
            <div class="mb-5 grid gap-4 md:grid-cols-3">
                <div class="panel rounded-2xl p-5">
                    <div class="text-sm text-slate-400">Традиционный ЦОД</div>
                    <div class="mt-3 text-3xl font-black text-red-300">PUE 1.70</div>
                    <div class="mt-2 text-xs text-slate-500">WUE 1.5 л/кВт·ч</div>
                </div>
                <div class="panel rounded-2xl p-5">
                    <div class="text-sm text-slate-400">ServerDomes · США</div>
                    <div class="mt-3 text-3xl font-black text-blue-300">PUE 1.13</div>
                    <div class="mt-2 text-xs text-slate-500">WUE 0.1 л/кВт·ч</div>
                </div>
                <div class="rounded-2xl border border-emerald-400/50 bg-emerald-400/10 p-5">
                    <div class="text-sm text-emerald-200">GeoClimate South</div>
                    <div class="mt-3 text-3xl font-black text-emerald-300">PUE 1.03</div>
                    <div class="mt-2 text-xs text-emerald-200/60">WUE 0.00 л/кВт·ч</div>
                </div>
            </div>
            <div class="grid gap-5 lg:grid-cols-[.65fr_1.35fr]">
                <div class="panel rounded-2xl p-5">
                    <h3 class="mb-5 font-bold text-white">Эффект за год</h3>
                    <div class="space-y-4">
                        <div>
                            <div class="text-xs text-slate-500">Экономия энергии</div>
                            <div id="ecoKwh" class="mt-1 text-2xl font-black text-emerald-300">5 869 200 кВт·ч</div>
                        </div>
                        <div>
                            <div class="text-xs text-slate-500">Финансовая выгода</div>
                            <div id="ecoKzt" class="mt-1 text-2xl font-black text-white">146 730 000 ₸</div>
                        </div>
                        <div>
                            <div class="text-xs text-slate-500">Предотвращено CO₂</div>
                            <div id="ecoCo2" class="mt-1 text-2xl font-black text-cyan-300">4 108 т</div>
                        </div>
                    </div>
                </div>
                <div class="panel rounded-2xl p-5">
                    <h3 class="mb-3 font-bold text-white">Затухание суточной волны в стене 0.5 м</h3><canvas
                        id="thermalChart"></canvas>
                </div>
            </div>
        </section>
        <section id="tab-d" class="tab-content">
            <div class="mb-5">
                <p class="text-xs uppercase tracking-widest text-emerald-400">Раздел D · научный гид ТЭТ</p>
                <h2 class="text-2xl font-bold text-white">Карта пяти точек экспедиции</h2>
            </div>
            <div class="grid gap-5 lg:grid-cols-[1.5fr_.5fr]">
                <div class="panel rounded-2xl p-3">
                    <div id="map"></div>
                </div>
                <div class="panel rounded-2xl p-5">
                    <h3 class="mb-4 font-bold text-white">Телеметрия</h3>
                    <div id="siteInfo" class="text-sm leading-6 text-slate-400">Выберите маркер на карте.</div>
                    <div class="mt-6 border-t border-slate-700 pt-4">
                        <div class="mb-2 text-xs uppercase tracking-widest text-emerald-300">Физический блок</div>
                        <div class="grid grid-cols-2 gap-2 text-xs">
                            <div class="rounded-lg bg-slate-950/60 p-3"><span
                                    class="block text-slate-500">Атмосфера</span>T, P, RH</div>
                            <div class="rounded-lg bg-slate-950/60 p-3"><span
                                    class="block text-slate-500">Динамика</span>v, Γ, ΔP</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section id="tab-ai" class="tab-content">
            <div class="mb-5">
                <p class="text-xs uppercase tracking-widest text-emerald-400">Дополнительный инструмент</p>
                <h2 class="text-2xl font-bold text-white">ИИ-консультант GeoClimate South</h2>
            </div>
            <div class="panel overflow-hidden rounded-2xl"><iframe
                    src="https://www.chatbase.co/center-stage-iframe/oxbL1UaXNy2MvQ0ld34HP"
                    title="ИИ-консультант GeoClimate South" class="h-[680px] w-full border-0"
                    allow="microphone"></iframe></div>
        </section>
    </main>
    <script>
        const $ = id => document.getElementById(id); const fmt = (value, digits = 0) => Number(value).toLocaleString('ru-RU', { maximumFractionDigits: digits, minimumFractionDigits: digits });
        window.switchTab = function (tabId) { document.querySelectorAll('.tab-btn').forEach(item => item.classList.toggle('active', item.dataset.target === tabId)); document.querySelectorAll('.tab-content').forEach(item => item.classList.toggle('active', item.id === tabId)); if (tabId === 'tab-d') setTimeout(() => map.invalidateSize(), 80); };
        document.querySelectorAll('.tab-btn').forEach(button => button.addEventListener('click', () => window.switchTab(button.dataset.target)));
        const crops = { apples: ['Яблоки / груши', '0…+4 °C', '90–95%', '6–8 мес'], grapes: ['Виноград', '0…+2 °C', '90–95%', '3–5 мес'], tomatoes: ['Томаты / перцы', '+8…+12 °C', '85–90%', '2–4 нед'], potatoes: ['Картофель / лук', '+2…+6 °C', '85–95%', '5–8 мес'] }; $('storageTable').innerHTML = Object.values(crops).map(row => `<tr><td class="p-3 text-white">${row[0]}</td><td class="p-3 text-emerald-300">${row[1]}</td><td class="p-3">${row[2]}</td><td class="p-3">${row[3]}</td></tr>`).join('');
        function updateAgro() { const z = +$('depth').value; const tons = +$('tonnage').value; const crop = $('crop').value; const attenuation = Math.exp(-z * Math.sqrt(Math.PI / (365 * .043))); const temp = 20 + 15 * attenuation; const panels = Math.ceil(tons * ({ apples: .3, grapes: .26, tomatoes: .22, potatoes: .34 }[crop])); const saving = tons * ({ apples: 15000, grapes: 17000, tomatoes: 12000, potatoes: 13500 }[crop]) + z * 50000; $('tonnageValue').textContent = `${fmt(tons)} т`; $('depthValue').textContent = `${z.toFixed(1)} м`; $('cropTemp').textContent = `${temp.toFixed(1)} °C`; $('panelArea').textContent = `${panels} м²`; $('cropSave').textContent = `${Math.min(96, 68 + z * 2.8 + (crop === 'potatoes' ? 4 : 0)).toFixed(0)}%`; $('cropEconomy').textContent = `${fmt(saving)} ₸`; } ['tonnage', 'depth', 'crop'].forEach(id => $(id).addEventListener('input', updateAgro)); updateAgro();
        function updateHouse() { const area = +$('area').value, wall = +$('wall').value, dome = +$('dome').value; const depth = Math.min(10, Math.max(1.8, 1.2 + 1.1 / wall)); const v = Math.sqrt(2 * 9.81 * dome * (5 / 300)); $('areaValue').textContent = `${fmt(area)} м²`; $('wallValue').textContent = `${wall.toFixed(1)} м`; $('domeValue').textContent = `${dome.toFixed(1)} м`; $('cellarDepth').textContent = `${depth.toFixed(1)} м`; $('draftSpeed').textContent = `${v.toFixed(2)} м/с`; $('tempDrop').textContent = `${Math.min(8, Math.max(5, v * 2.8)).toFixed(1)} °C`; $('treeCooling').textContent = `−${(2.3 + area / 200).toFixed(1)} °C`; } ['area', 'wall', 'dome'].forEach(id => $(id).addEventListener('input', updateHouse)); updateHouse();
        function updateIndustry() { const load = +$('load').value, saved = load * (1.70 - 1.03) * 8760; $('loadValue').textContent = `${fmt(load)} кВт`; $('ecoKwh').textContent = `${fmt(saved)} кВт·ч`; $('ecoKzt').textContent = `${fmt(saved * 25)} ₸`; $('ecoCo2').textContent = `${fmt(saved * .7 / 1000, 1)} т`; } $('load').addEventListener('input', updateIndustry); updateIndustry();
        const hours = Array.from({ length: 25 }, (_, i) => `${i}:00`);
        const outdoorWave = hours.map((_, i) => 35 + 10 * Math.sin(i * Math.PI / 12 - 2));
        const indoorWave = hours.map((_, i) => 24 + 1.5 * Math.sin(i * Math.PI / 12 - 2));
        new Chart($('thermalChart'), { type: 'line', data: { labels: hours, datasets: [{ label: 'Улица', data: outdoorWave, borderColor: '#fb7185', tension: .35 }, { label: 'После стены 0.5 м', data: indoorWave, borderColor: '#34d399', tension: .35 }] }, options: { responsive: true, plugins: { legend: { labels: { color: '#cbd5e1' } } }, scales: { x: { ticks: { color: '#94a3b8' }, grid: { color: '#1e293b' } }, y: { ticks: { color: '#94a3b8' }, grid: { color: '#1e293b' } } } } });
        const sites = [{ coords: [42.9238, 69.7027], title: 'Пещера Ақмешіт', data: 'Улица: 30.0 °C · 950.2 hPa · RH 22%<br>Дно 14.5 м: 15.0 °C · 951.8 hPa · RH 72%', physics: 'Cold Air Pool: Δρ = 0.059 кг/м³, давление запирания ΔP = 7.18 Па. В модели это естественный буфер холода.' }, { coords: [42.6025, 69.1719], title: 'Плато Ордабасы / музей Кажымукана', data: 'Почва: 48.0 °C на поверхности · 22.0 °C на 15 см<br>Ветер: 2.0 м/с · угол маятника 15°', physics: 'Затухание температурной волны в суглинке: α ≈ 0.5 × 10⁻⁶ м²/с. Поверхностный перегрев не проникает быстро в грунт.' }, { coords: [43.2975, 68.2707], title: 'Түркістан · Восточная баня', data: 'Улица: 31.3 °C, пик 34.4 °C, RH <20%<br>Сухой 23.9 °C · влажный 22.5 °C · пол 24.1 °C', physics: 'Адиабатическое испарение: RHcalc = 88.9%. Кирпичная тепловая инерция и вытяжка над куполом снижают нагрузку.' }, { coords: [42.4411, 70.4851], title: 'Ақсу-Жабағылы · Кіші Қайыңды', data: 'Равнина: 27.8 °C · 950 hPa<br>Ущелье 1545 м: 17.6 °C · 842 hPa · Γ = 9.76 °C/км<br>Ручей: Td 15.1 °C · Tw 11.8 °C · RH 69.8%', physics: 'Эффект Вентури v = 2.8 м/с и катабатический сток воздуха. Узкое сечение усиливает обмен.' }, { coords: [42.3417, 69.5901], title: 'Этномузей «Қылует» · Шымкент', data: 'Пик улицы: 41.5 °C · RH <20%<br>Хильвет 7 м: 20.2…21.9 °C · RH 41…49%', physics: 'Подземный термостат: ΔT = 21.3 °C, годовая волна затухает примерно в 23 раза. Это базовый сценарий для погреба.' }];
        const map = L.map('map').setView([42.7, 69.5], 8); L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', { attribution: '&copy; CARTO' }).addTo(map); sites.forEach(site => { const marker = L.circleMarker(site.coords, { radius: 9, fillColor: '#34d399', color: '#071412', weight: 2, fillOpacity: .9 }).addTo(map); marker.bindPopup(`<b>${site.title}</b><br><small>${site.data}</small>`); marker.on('click', () => $('siteInfo').innerHTML = `<h4 class="mb-3 text-lg font-bold text-white">${site.title}</h4><div class="leading-7">${site.data}</div><div class="mt-4 border-t border-slate-700 pt-4 text-emerald-200">${site.physics}</div>`); });
    </script>
</body>

</html>
