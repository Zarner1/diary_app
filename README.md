                                    Günlük Uygulaması
    Geliştiriciler:
        Esat Küçe-030122036
        Ritvan Angous-030122069
        Muhammed Sait Yıldırım-030122026
		
    Görev Dağılımı:
	Esat: UI Tasarlama, Kodlama
	Ritvan: Veritabanı Bağlantıları, Kodlama
	Sait: Proje taslağı oluşturma, Asset'leri bulmak, Kodlama
    
    Proje Amacı:
        Bu proje, kullanıcıların email ve şifre ile giriş yaparak günlüklerini yazabilecekleri bir uygulamadır.
        Veriler yerel olarak JSON formatında saklanır. Bu proje, Flutter framework'ü kullanılarak geliştirilmiştir.

    Özellikler:
        Kullanıcı girişi 
        Günlük oluşturma ve kaydetme
        Basit ve kullanışlı bir arayüz

    Geliştirilmekte Olan Özellikler:
	Ayarlar bölümü
	Yeni yazı fontları
	Karanlık tema
	Başkalarıyla günlük paylaşabilme

    Kullanılan Teknolojiler:
        Flutter: Mobil çapraz platform uygulama geliştirme framework'ü
        JSON: Kullanıcı verilerinin yerel olarak saklanması için kullanılan format
        Abstraction: Her sayfa farklı dosyalarda programlanarak performans artışı sağlanır
        Future: Asenkron olarak dosya okuma ve api işlemleri yönetimi için kullanılır
        Hata Ayıklama: Try-Catch ile hata yönetimi sağlanır
        API ve İnternet Erişimi: Uygulamaya internet erişim izni verilerek, API’lar üzerinden veri akışı ve logoların internetten alınması sağlanmıştır.

    Kullanıcı Girişi:
        Uygulama, kullanıcıların giriş yapabilmesi için bir email ve şifre gerektirir 
        Giriş yaptıktan sonra, kullanıcılar günlüklerini oluşturabilir ve kaydedebilir

    Giriş İşlemi:
	Kullanıcının hesabı yoksa email ve şifre ile kayıt olabilir
        Kullanıcı email ve şifre ile giriş yapabilir
        Giriş başarılıysa, kullanıcıya günlük yazma ekranı açılır
	
    Günlük Yazma:
        Kullanıcılar günlüklerini yazabilir, kaydedebilir ve düzenleyebilir

    Uygulama Mimarisi:
        Register Ekranı: Yeni bir kullanıcı oluşturmak için kullanılır.
        Login Ekranı: Kullanıcı email ve şifresini girer.
        Günlük Ekranı: Kullanıcı günlük yazabilir ve kaydedebilir
	Günlük Listeleme Ekranı: Kullanıcı eski günlüklerine erişebilir
	Drawer: Kullanıcı yeni günlük ekleyebilir, eski günlüklerini okuyabilir, 
	   	geliştirilmekte olan ayarlar ekranına erişebilir ve uygulamadan çıkış yapabilir.
     		Ayrıca uygulama logosunu bir API ile burada tutulur.
     	Diary_entry: Günlüklerin giriş formatını tutan sayfa
      	User: Kullanıcıların bilgilerinin formatını tutan sayfa
        Auth_Service: Kullanıcıların giriş ve kayıt bilgilerinin doğruluğu sağlar
        Diary_Service: Günlüklerin kaydının tutulmasını sağlar

    Geliştirici Notları:
        Bu uygulama, Flutter ve Dart kullanılarak geliştirilmiştir.
        Veriler JSON formatında yerel olarak saklanmaktadır.
        Uygulamanın tam kapasitede çalışabilmesi için bazı fonksiyonların geliştirilmesinde Stack Overflow gibi kaynaklardan faydalanılmıştır.    
        

    Lisans:
        Bu projede kullanılan yazılımlar ve teknolojiler açık kaynaklıdır. Projeyi ve kodları kendi ihtiyaçlarınıza göre değiştirebilirsiniz.
