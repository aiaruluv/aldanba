import 'package:flutter/material.dart';

void main() {
  runApp(const AldanbaApp());
}

class AldanbaApp extends StatelessWidget {
  const AldanbaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aldanba',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF0033FF), // Глубокий синий из дизайна
        fontFamily: 'Roboto',
      ),
      home: const MainNavigation(),
    );
  }
}

// Главный экран с навигацией
class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const VoiceCheckScreen(),
    const AlertScreen(), // Для демонстрации вывел экран тревоги в меню
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: const Color(0xFF0033FF),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.record_voice_over), label: 'Голоса'),
          BottomNavigationBarItem(icon: Icon(Icons.warning_amber_rounded), label: 'Демо Тревоги'),
        ],
      ),
    );
  }
}

// ---------------- ЭКРАН 1: ГЛАВНАЯ (Dashboard) ----------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Синяя шапка
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF0033FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Aldanba', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    Stack(
                      children: [
                        const Icon(Icons.notifications, color: Colors.white),
                        Positioned(right: 0, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                const Text('Добро пожаловать', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 5),
                const Text('Защита активна', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, color: Colors.greenAccent, size: 16),
                      SizedBox(width: 5),
                      Text('Мониторинг близких включён', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
          
          // Кнопки быстрых действий
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(Icons.phone, 'Звонки'),
                _buildActionButton(Icons.message, 'Сообщения'),
                _buildActionButton(Icons.info_outline, 'О рисках'),
                _buildActionButton(Icons.security, 'Защита'),
              ],
            ),
          ),

          // Последние события
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Последние события', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildEventCard('Подозрительный звонок', 'Обнаружены признаки синтетической речи · Сегодня, 09:14', 'Deepfake', Colors.redAccent),
                _buildEventCard('Голос проверен — Мама', 'Совпадение 94% с эталоном · Вчера, 17:32', 'Настоящий', Colors.green),
                _buildEventCard('Новая схема мошенников', 'Как распознать срочные просьбы о деньгах', 'Обучение', Colors.grey),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
          child: Icon(icon, color: const Color(0xFF0033FF), size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildEventCard(String title, String subtitle, String tag, Color tagColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: tagColor.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: Text(tag, style: TextStyle(color: tagColor, fontSize: 12, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

// ---------------- ЭКРАН 2: ПРОВЕРКА ГОЛОСА ----------------
class VoiceCheckScreen extends StatelessWidget {
  const VoiceCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Проверка голоса', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 5),
            const Text('Сохранённые образцы близких', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            _buildVoiceProfile('МА', 'Мама', '3 образца · обновлено 2 дня назад', 94),
            const SizedBox(height: 15),
            _buildVoiceProfile('ПА', 'Папа', '2 образца · обновлено неделю назад', 88),
            
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Добавить голос\nЗапись нового образца', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceProfile(String initials, String name, String details, int matchPercentage) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: Colors.grey[800], child: Text(initials, style: const TextStyle(color: Colors.white))),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(details, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.graphic_eq, color: Colors.white54, size: 30),
               Icon(Icons.graphic_eq, color: Colors.white, size: 40),
               Icon(Icons.graphic_eq, color: Colors.white54, size: 30),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Последнее совпадение', style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text('$matchPercentage%', style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}

// ---------------- ЭКРАН 3: ТРЕВОГА (ALERT) ----------------
class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Красный баннер предупреждения
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.redAccent,
              child: const Column(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text('Предупреждение!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('Обнаружен возможный deepfake', style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.redAccent, width: 4),
                      ),
                      child: const Text('87%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(child: Text('Высокий риск мошенничества', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))),
                  const Center(child: Text('Речь скорее всего сгенерирована искусственно.\nНЕ ПЕРЕВОДИТЕ ДЕНЬГИ.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))),
                  
                  const SizedBox(height: 20),
                  const Text('Признаки обнаружены:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  const Text('• Синтетические артефакты в голосе', style: TextStyle(color: Colors.redAccent)),
                  const Text('• Несовпадение с эталонным голосом мамы', style: TextStyle(color: Colors.redAccent)),
                  const Text('• Эмоциональное давление и срочность', style: TextStyle(color: Colors.redAccent)),
                  
                  // Добавленная фича из прошлого диалога
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: Colors.blueAccent),
                        SizedBox(width: 10),
                        Expanded(child: Text('Совет: Спросите у звонящего ваш семейный пароль или кличку первой собаки.', style: TextStyle(color: Colors.white70, fontSize: 12))),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.symmetric(vertical: 15)),
                          child: const Text('Заблокировать', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 15)),
                          child: const Text('Позвонить близким', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}