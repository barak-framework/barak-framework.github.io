# BARAK FRAMEWORK vX

## Barak Framework Nedir ?

Barak Framework PHP diliyle yazılmış, açık kaynak kodlu bir web uygulama geliştirme çatısıdır. Web uygulamaları için ihtiyaç duyulabilecek bütün bileşenleri barındıran Barak; MVC (model-view-controller), DRY (don't repeat yourself), CoC (convention over configuration) yaklaşımlarını temel alır. Barak ile aktif hızlı ve kolay RESTful web uygulamaları yapabilirsiniz.

### Gereksinimler

1. Programlama Dili : `Php >= 5.4`
2. Veritabanı Sürücüsü : `PDO`
3. Web Sunucuları :
    1. `Apache`
    2. `Nginx`
    3. `ISS`
4. Paket Yöneticisi : `Composer`

Barak Framework için gerekli olan paketler yukarıda verilmiştir. Bu paketlerin nasıl kurulacağına ilişkin aşağıdaki bağlantıları inceleyebilirsiniz.

> Linux, Apache, MySQL, Php Kurulum : [LAMP](https://barak-framework.github.io/blog/categories/linux/lamp/)

> Linux, Nginx, MySQL, Php Kurulum : [LEMP](https://barak-framework.github.io/blog/categories/linux/lemp/)

> Web Sunucu Ayarları : [apache2-settings](https://github.com/barak-framework/barak/blob/master/.htaccess.sample) veya [nginx-settings](https://github.com/barak-framework/barak/blob/master/nginx.config.sample) veya [iss-settings](https://github.com/barak-framework/barak/blob/master/web.config.sample)

> Paket Yönetici Kurulumu : [composer-installation](https://barak-framework.github.io/blog/categories/php/composer/)

### Barak Kurulum

```sh
composer create-project barak-framework/barak project_name
```

### Çalıştır

    cd project_name
    php -S localhost:9090

and check homepage : [http://localhost:9090](http://localhost:9090) and thats all!

### Versiyonlar

- [https://github.com/barak-framework/barak/releases](https://github.com/barak-framework/barak/releases)

### Lisans

Barak is released under the [MIT License](http://www.opensource.org/licenses/MIT).

---

## Guides

### Configurations (`config/*`)

---

Uygulama çalışmadan önce bazı yapılandırma ayarlarının yapıldığı kısımdır.

- Files

> `config/application.php`, `config/cacher.ini`, `config/database.ini`, `config/mailer.ini`, `config/locales/LANGUAGE.php`, `config/routes.php`

#### Files

##### `config/application.php` (application configuration file)

Uygulama ayarlarının yapıldığı dosyadır. Ayar seçeneklerini kullanmak zorunlu değildir.

- Methods

> `set`, `modules`

- Options General

> `timezone`, `debug`, `locale`, `logger`

- Options Modules

> `cacher`, `http`, `mailer`, `model`

```php
// Ör.:
Application::config(function() {
  set("timezone", "Europe/Istanbul"); // saat dilim ayarı
  set("debug", true);                 // yanılgıları göster
  set("locale", "tr");                // config/locales/tr.php
  set("logger", [
    "file" => "production",           // dosya ismi
    "level" => "info",                // en kapsamlı yaz
    "driver" => "weekly",             // haftalık
    "rotate" => 4,                    // 4 yedek
    "size" => 15728640                // 15 MB
  ]);

  // bu modüller kullanılsın
  modules(["cacher", "http", "mailer", "model"]);
  // veya aşağıdaki gibi modules atanabilir
  set("cacher", true);
  set("http", true);
  set("mailer", true);
  set("model", true);
});
```

###### Methods

> `set`: Ayar değişkenine değeri atamada kullanılır.

> `modules`: Ayar değişkenine `true` değerini atamada kullanılır.

###### Options

> `debug` [= true]

Uygulama üzerinde oluşan Exception, Error, Shutdown(Fatal Error) yanılmalarını yakalayıp Yazılımcı Modu(`true`) veya Kullanıcı Modu(`false`) şeklinde gösterilmenin ayarlandığı anahtardır.

1. `true`  : [Yazılımcı Modu] Adım adım hangi dosyada, hangi satırda, yanılmanın nedenini gösterilmek isteniyorsa kullanılır.
2. `false` : [Kullanıcı Modu] Sadece uygulamanın çalışmadığını üstü kapalı bir şekilde gösterilmek isteniyorsa kullanılır, `public/500.html` sayfası gösterilir.

Ancak her türlü ayarlamada da log kaydı tutulur. Daha ayrıntılı bilgi için `Logger` kısmına bakınız.

> `timezone` [= Europe/Istanbul]

PHP'nin zaman ayarlamasının yapıldığı anahtardır. Ayrıntılı bilgi için `PHP#date_default_timezone_set` fonksiyonuna bakınız.

> `locale` [= tr]

`config/locales/*` altındaki `tr.php`, `en.php` gibi dosyaların, hangisinin varsayılan olarak seçileceğinin ayarlandığı anahtardır. Daha ayrıntılı bilgi için `I18n` kısmına bakınız.

> `logger` [= ["file" => "production", "level" => "info", "driver" => "weekly", "rotate" => 4, "size" => 5242880]]

`tmp/log/` altında oluşturulacak log dosyasının hangi ad, seviye, sürücü, döndürme sayısı, byte boyutu belirtilerek ayarlandığı anahtardır.

1. `file` : Yazılacak olan log dosyasının adı için kullanılır.
2. `level` : Sadece seçtiğiniz seviyenin(kendisi dahil) **kapsadığı seviyeleri** yazmak için kullanılır. Ör.: `warning` seviyesi seçilirse `info` seviyeli duyuru içerikleri log dosyasına yazılmayacaktır.

(Seviyeler(levels): `info`, `warning`, `error`, `debug`, `fatal` | Kapsamlar(scopes): **info** > **warning** > **error** > **debug** > **fatal**)
3. `driver` : Log dosyasının hangi gün boyunca tutulması gerektiğini belirtmek için kullanılan sürücülerdir. Ör.: `weekly` sürücüsü seçilirse 7 gün boyunca bu dosyaya yazar ve 7 günün sonunda bu dosyayı yedek dosya olarak taşır; tekrardan yeni bir 7 günlük yazılacak log dosyası oluşturur.

(Sürücüler(drivers) : `yearly`, `mountly`, `weekly`, `daily` | Günler(days): `yearly`:365, `mountly`:30, `weekly`:7, `daily`: 1)
4. `rotate` : Tutulacak yedek dosyalarının kaç adet olacağını(döndürüleceğini) belirtmek için kullanılır.
5. `size` : Eğer log dosyası belli bir boyutu aştıysa yedek dosya olarak taşınıp tekrardan yeni bir yazılacak log dosyası oluştururmak için kullanılır.

Daha ayrıntılı bilgi için `Logger` kısmına bakınız.

###### Modules

> `cacher` [= false]

Cacher sınıfını etkin kılan anahtardır.

> `http` [= false]

Http sınıfını etkin kılan anahtardır.

> `mailer` [= false]

Mailer sınıfını etkin kılan anahtardır.

> `model` [= false]

Model sınıfını etkin kılan anahtardır.

##### `config/database.ini` (database configuration file)

Veritabanı ayarlarının yapıldığı dosyadır. Ayar seçeneklerini kullanmak **zorunludur.**

- Options

> `adapter`, `hostname`, `username`, `database`, `password`

```ini
; Ör.:
[database_configuration]
adapter  = mysql
hostname = localhost
database = BARAK
username = root
password = barak
```

###### `adapter`

Veritabanı sürücüsü olarak `PDÒ` kullanıldığı için [`PDOnun desteklediği veritabanları`](http://php.net/manual/tr/pdo.drivers.php) seçilmelidir.

| Desteklenen Veritabanı | Veritabanı Sürücü İsmi (Ör.: `adapter = mysql`) |
| --- | ---: |
| CUBRID Functions | `cubrid` |
| Microsoft SQL Sunucusu ve Sybase | `dblib` |
| Firebird/Interbase | `firebird` |
| IBM | `ibm` |
| Informix | `informix` |
| MySQL | `mysql` |
| Microsoft SQL Server Functions | `sqlsrv` |
| Oracle | `oci` |
| ODBC ve DB2 | `odbc` |
| PostgreSQL | `pgsql` |
| SQLite  | `sqlite` |

###### `hostname`

Veritabanı hostunun adı

###### `username`

Veritabanı kullanıcısının adı

###### `database`

Veritabanı adı

###### `password`

Veritabanı parolası

###### `size` [= 5242880]

Log dosyasının maximum ulaşabileceği boyutun ayarlandığı anahtardır. Varsayılan olarak boyut 5242880 byte (5 megabyte) şeklindedir. Eğer belirlenen boyut aşılırsa dosyaya yazmayı keser.

###### `level` [= info, warning, error, debug, fatal]

Log yazma seviyesinin ayarlandığı anahtardır. Mevcut log seviyelerinden seçilmelidir. Uygulamada kullanılan log isminin seviyeleri, yapılandırma dosyasında girilen log seviyesinden küçük ise log bilgisini, log dosyasına yazmayacaktır. (Ör.: `level = debug` ise `ApplicationLogger::info("bilgi var!");` şeklindeki log bilgisini log dosyasına yazmayacaktır. Çünkü `info`, log seviyesi `0` şeklindedir.) Kapsam şu şekildedir :

`info` > `warning` > `error` > `debug` > `fatal`

| Log İsmi | Log Seviyesi |
| --- | --- |
| `info`    | `0` |
| `warning` | `1` |
| `error`   | `2` |
| `debug`   | `3` |
| `fatal`   | `4` |

##### `config/mailer.ini` (mailer configuration file)

Mail ayarlarının yapıldığı dosyadır. `PHPMailer` eklentisini kullanmaktadır. Ayar seçeneklerini kullanmak **zorunludur.**

- Options

> `port`, `address`, `username`, `password`

- Default SMTP Configuration (Test Edildi)

```ini
; Ör.:
[mailer_configuration]
port     = 25
address  = mail.gdemir.me
username = mail@gdemir.me
password = 123456
```

- Yandex SMTP Configuration (Test Edildi)

```ini
; Ör.:
[mailer_configuration]
port     = 587
address  = smtp.yandex.com
username = mail@gdemir.me
password = 123456
```

- Gmail SMTP Configuration (Test Edilmedi, Gmail'in kendi problemi var)

```ini
; Ör.:
[mailer_configuration]
port     = 465
address  = smtp.gmail.com
username = mail@gdemir.me
password = 123456
```

###### `port`

Mail web servis adresine hangi porttan bağlanacağını belirleyen anahtardır.

###### `address`

Mail web servisi adresinin belirleyen anahtardır.

###### `username`

Mail web servisine hangi kullanıcı ile bağlanacağını belirleyen anahtardır.

###### `password`

Mail web servisine hangi parola ile bağlanacağını belirleyen anahtardır.

##### `config/locales/LANGUAGE.php` (language configuration file)

Varsayılan olarak okunan `config/locales/tr.php` dosyasıdır, yeni bir dil eklenecekse aynı `list` kullanılıp değer kısımları değiştirilerek kaydedilmelidir. Daha ayrıntılı bilgi için `I18n` kısmına bakınız.

`config/locales/tr.php`

```php
<?php
return [

"home" => [
  "link" => "Anasayfa",
  "about_us" => "Hakkımızda"
  ]

];
?>
```

`config/locales/en.php`

```php
<?php
return [

"home" => [
  "link" => "Homepage",
  "about_us" => "About Us"
  ]

];
?>
```
##### `config/routes.php` (route configuration file)

Daha ayrıntılı bilgi için `Router` kısmına bakınız.

### Simple Usage

---

Basit bir URL olarak `/` yönlendirme isteği geldiğinde Barak Framework uygulamasının takip edeceği `Router`, `Controller`, `Views`, `Layouts` adımlarını genel hatlarıyla görebilmek için aşağıdaki örneği inceleyebilirsiniz.

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("", "home#index");
});
```

> `app/controller/HomeController.php`

```php
class HomeController extends ApplicationController {

  public function index() {
    $this->message = "Hello World";
  }

}
```

> `app/views/home/index.php`

```php
<h1> Home/Index </h1>;
<?= $message; ?>
```

> `app/views/layouts/home.php`

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="tr" lang="tr">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title></title>
</head>
<body>
  <?= $yield; ?>
</body>
</html>
```

### Router (`config/routes.php`)

---

Herhangi bir istek URL çalışabilmesi için yönlendirilme dosyasında (`config/routes.php`) ne tür bir istek olduğu tanımlanmalıdır. Eğer istek URL `get`, `post` methodu değilse `public/500.html` sayfası, `get`, `post` methodu ama eşleşen bir istek bulunmuyorsa `public/404.html` sayfası gösterilir. Yönlendirme fonksiyonları olan `get`, `post`, `resource`, `resources`, `scope`, `root` fonksiyonları tanımlama yapılmadan önce  tetikleyici `draw` fonksiyonu içerisine yazılmalıdır.

- Kick Method (static)

> `draw`

- Methods (global)

> `get`, `post`, `resource`, `resources`, `scope`, `root`

#### Kick Method

##### `draw` (`function() { /* ROUTE_FUNCTIONS */ }`)

Tanımlaması yapılan yönlendirmelerin okunması ve çalışması için tetikleyici fonksiyondur. Bu fonksiyon ikinci kez kullanıldığında işleme almamaktadır.

```php
ApplicationRoutes::draw(function() {
  /* ROUTE_FUNCTIONS */
});
```
#### Methods

##### `get` ($rule, $target = false, $path = "")

- Simple

Yönlendirici isteği olan `/home/index` gibi bir yapının gideceği rota `controller : HomeController`, `action : index` şeklindedir.

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("home/index");
});
```

- Target

Yönlendirici isteği olan `/home/index` gibi bir yapının gideceği rota `controller : HomeController`, `action : index` şeklindedir. Ancak bu rotayı değiştirebiliriz, aşağıdaki örnekte gideceği rota `controller : HomeController`, `action : about` şeklinde belirlenmiştir.

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("home/index", "home#about");
});
```

- Dynamical Segment

`:` ile başlayan dinamik denetleyici tanımlamalarında (Ör.: `:id`) yönlendirici isteklerinin, denetleyici eylemiyle eşleşmesini ister. Örneğin `/home/index/12`, `/home/index/foo` gibi yönlendiri istekleri, tanımlanmış denetleyici `/home/index/:id` yapısında eşleşme sağlar. Ayrıca "home#index" `controller#action` gibi hedef belirtilmesi **zorunludur**. Dinamik denetleyici tanımlamalarında ki `$id` gibi parçalara erişim örneği aşağıda verilmiştir.

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("home/index/:id", "home#index");
});
```

> `app/controllers/HomeController.php`

```php
class HomeController extends ApplicationController {

  public function index() {
    $this->id = 1071;
  }

}
```

> `app/views/home/index.php`

```php
<h1> Home#Index </h1>;
<?= "id: $id"; ?>
```

##### `post` ($rule, $target = false, $path = "")

- Simple

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  post("admin/login");
});
```

> `app/controllers/AdminController.php`

```php
class AdminController extends ApplicationController {

  protected $before_actions = [
  ["require_login", "except" => ["login", "logout"]]
  ];

  public function login() {

    if (isset($_SESSION["admin"]))
      return $this->redirect_to("admin/index");

    if (isset($_POST["username"]) and isset($_POST["password"])) {

      if ($user = User::unique(["username" => $_POST["username"], "password" => md5($_POST["password"])])) {

        $_SESSION["success"] = "Admin sayfasına hoş geldiniz";
        $_SESSION["full_name"] = "$user->first_name $user->last_name";
        $_SESSION["admininfo"] = $user;
        $_SESSION["admin"] = true;

        return $this->render("admin/index");

      } else {

        $_SESSION["danger"] = "Oops! İsminiz veya şifreniz yanlış, belki de bunlardan sadece biri yanlıştır?";

      }
    }

    return $this->render(["layout" => "default"]);
  }

  // public function index() {} // OPTIONAL

  public function logout() {
    if (isset($_SESSION["admin"]))
      session_destroy();
    return $this->redirect_to("admin/login");
  }

  public function require_login() {
    if (!isset($_SESSION["admin"])) {
      $_SESSION["warning"] = "Lütfen hesabınıza giriş yapın!";
      return $this->redirect_to("admin/login");
    }
  }
}
```

> `app/views/admin/index.php`

```php
<h1> Admin#Index </h1>;
<?= $_SESSION["full_name"]; ?>
```

##### `resource` ($rule, $path = "")

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  resource("users");
});
```

> *Aşağıdaki routes kümesini üretir.*

```php
ApplicationRoutes::draw(function() {
  get("users", "users#index");  // all record
  get("users/create");          // new record form
  post("users/save");           // new record save
  get("users/show");            // display record
  get("users/edit");            // edit record
  post("users/update");         // update record
  post("users/destroy");        // destroy record
});
```

##### `resources` ($rule, $path = "")

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  resources("users");
});
```

> *Aşağıdaki routes kümesini üretir.*

```php
ApplicationRoutes::draw(function() {
  get("users", "users#index");         // all record
  get("users/create");                 // new record form
  post("users/save");                  // new record save
  get("users/show/:id", "users#show"); // display record
  get("users/edit/:id", "users#edit"); // edit record
  post("users/update");                // update record
  post("users/destroy");               // destroy record
});
```

##### `scope` ($path, callable $routes)

Kodları daha derli toplu kullanmak için Route'in gruplama özelliğidir. Bir `PATH` altında `CONTROLLER` ve `VIEW` dizininin çalışma imkanı sağlar.

`PATH` altındaki sınıflara üst sınıf olarak `{PATH}Controller` isminde sınıfı da yükler. Bu üst sınıf, alt sınıflar tarafından miras alınacak şekilde ayarlanırsa `PATH` altındaki tüm sınıflarda kullanılacak `helpers`, `before_actions`, `after_actions` özelliklerini ortak havuz gibi kullanma imkanı sağlar.

- Simple

Aşağıdaki örnek route yapılandırmasına göre şu sınıfları yüklenecektir:

`app/controllers/admin/CategoriesController.php`

`app/controllers/AdminController.php`

Üst sınıf aşağıdaki gibi olduğunu düşünelim:

```php
class AdminController extends ApplicationController {

  protected $helpers = ["Password"];

  protected $before_actions = [["require_login"]];

  public function require_login() {
    if (!isset($_SESSION["admin"])) {
      $_SESSION["warning"] = "Lütfen hesabınıza giriş yapın!";
      return $this->redirect_to("admin/login");
    }
  }
}
```

Alt sınıf aşağıdaki gibi olduğunu düşünelim:

```diff
+ class CategoriesController extends AdminController {
  public function index() {}
}
```

Alt sınıflar `AdminController` sınıfından miras almalıdır,  böylelikle bu `PATH` altındaki tüm sınıflara erişimde `app/helpers/PasswordHelper.php` sınıfı yüklenecek her erişim öncesi `require_login` methodu çalıştırılacaktır.

Buradaki Admin path'i altıdan yapılacak tüm işlemlerde login olma özelliği zorunlu kılınmış oldu. Bu da bize her sınıf altında `require_login` methodunun tekrar tekrar yazma zorluğundan bizi kurtarmış oldu.

> `config/routes.php`

view : `app/views/admin/categories/ACTION.php`

controller : `app/controllers/admin/CategoriesController.php`

path_controller : `app/controllers/AdminController.php`

```php
ApplicationRoutes::draw(function() {
 scope("admin", function() {
    resources("categories");
 });
});
```

> *Aşağıdaki routes kümesini üretir.*

```php
ApplicationRoutes::draw(function() {
  get("admin/categories",          "categories#index", "admin/");  // all record
  get("admin/categories/create",   false,              "admin/");  // new record form
  post("admin/categories/save",    false,              "admin/");  // new record save
  get("admin/categories/show/:id", "categories#show",  "admin/");  // display record
  get("admin/categories/edit/:id", "categories#edit",  "admin/");  // edit record
  post("admin/categories/update",  false,              "admin/");  // update record
  post("admin/categories/destroy", false,              "admin/");  // destroy record
});
```

- Multiple

view : `app/views/admin/dashboard/categories/ACTION.php`

controller : `app/controllers/admin/dashboard/CategoriesController.php`

path_controller1 : `app/controllers/AdminController.php`

path_controller2 : `app/controllers/admin/DashboardController.php`

```php
ApplicationRoutes::draw(function() {
  scope("admin", function() {
    scope("dashboard", function() {
      resources("categories");
    });
  });
});
```

> *Aşağıdaki routes kümesini üretir.*

```php
ApplicationRoutes::draw(function() {
  get("admin/dashboard/categories",          "categories#index", "admin/dashboard/");  // all record
  get("admin/dashboard/categories/create",   false,              "admin/dashboard/");  // new record form
  post("admin/dashboard/categories/save",    false,              "admin/dashboard/");  // new record save
  get("admin/dashboard/categories/show/:id", "categories#show",  "admin/dashboard/");  // display record
  get("admin/dashboard/categories/edit/:id", "categories#edit",  "admin/dashboard/");  // edit record
  post("admin/dashboard/categories/update",  false,              "admin/dashboard/");  // update record
  post("admin/dashboard/categories/destroy", false,              "admin/dashboard/");  // destroy record
});
```

- Mix

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("admin/login");
  scope("admin", function() {
    get("users", "users#index");
    get("users/show/:id");
    resources("categories");
    resource("products");
  });
});
```

> *Aşağıdaki routes kümesini üretir.*

```php
ApplicationRoutes::draw(function() {
  get("admin/login");

  get("admin/users",               "users#index",      "admin/");  // all record
  get("admin/users/show/:id",      false,              "admin/");  // display record

  get("admin/categories",          "categories#index", "admin/");  // all record
  get("admin/categories/create",   false,              "admin/");  // new record form
  post("admin/categories/save",    false,              "admin/");  // new record save
  get("admin/categories/show/:id", "categories#show",  "admin/");  // display record
  get("admin/categories/edit/:id", "categories#edit",  "admin/");  // edit record
  post("admin/categories/update",  false,              "admin/");  // update record
  post("admin/categories/destroy", false,              "admin/");  // destroy record

  get("admin/products",           "products#index",    "admin/");  // all record
  get("admin/products/create",     false,              "admin/");  // new record form
  post("admin/products/save",      false,              "admin/");  // new record save
  get("admin/products/show",       false,              "admin/");  // display record
  get("admin/products/edit",       false,              "admin/");  // edit record
  post("admin/products/update",    false,              "admin/");  // update record
  post("admin/products/destroy",   false,              "admin/");  // destroy record
});
```

##### `root` ($target = false, $path = "")

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  root("home#index");
});
```

> *Aşağıdaki routes kümesini üretir.*

```php
ApplicationRoutes::draw(function() {
  get("", "home#index");
});
```

### Controllers (`app/controllers/*.php`)

---

Her controller dosyası ile sınıfının ismi aynı **olmalıdır** ve sistemin olan `ApplicationController` sınıfından miras alır.

```php
// Ör.: dosya : `app/controllers/HomeController.php`
class HomeController extends ApplicationController {
}
```

Her `config/routes.php` içerisinde tanımlanan

1. `get` yönlendirmesi için  `app/controller/CONTROLLER.php` sınıfı içerisinde fonksiyon tanımlamak zorunlu değildir. Eğer fonksiyon tanımlanırsa ve değişken yükü/yükleri controller içinde `$this->KEY` şeklinde atandığında ilgili yönlenen sayfada (`app/views/CONTROLLER/ACTION.php`) bu veriye `$KEY` şeklinde erişme imkanı verir.
2. `post` yönlendirmesi için `app/controller/CONTROLLER.php` sınıfı içerisinde fonksiyon tanımlamak **zorunludur.**

- Methods

> `render`, `redirect_to`, `send_data`

- Options

> `helpers`, `before_actions`, `after_actions`

#### Methods

##### `render` ($view_options = [], $response_options = NULL) veya ($template = "", $response_options = NULL)

`redirect_to` fonksiyonuna göre farkı `Router` üzerinden normal bir istek gibi kontrolü **yapılmayan** , ilgili `Controller` ve `View` akışı **olmayan** istektir.

Örneğin bir `template` içeriği ile `layout` içeriğini birleştirirken `template` içerisinde `Controller` üzerinden gelmesi gereken `$id` gibi değişkenler var ve `template` üzerine gönderilecek bir `locals` yok ise yanılgıya düşecektir. #TODO

> view_options : `layout`, `view`, `action`, `template`, `file`, `partial`, `text`, `locals`

> response_options : `content_type`, `status_code`, `headers`

###### View Options

> [`view` ve `action`] veya [`template`]

Eylem oluşturma en yaygın biçimdir ve başka bir şey belirtilmediğinde Eylem Denetleyicisi tarafından otomatik olarak kullanılan türdür. Varsayılan olarak, eylemler mevcut mizanpaj içinde gerçekleştirilir (varsa).

`template` anahtar ayarı,

- `view/action` şeklinde ayar anahtarlarının birlikte kısa kullanımıdır.

- Sadece `locals`, `layout` ayar anahtarlarını kullanılabilir.

`layout` ayar anahtarı `FALSE` ise sadece `template` gösterilir.

```php
class HomeController extends ApplicationController {

  public function index() {

    // LAYOUT: home, VIEW: home, ACTION: index, LOCALS: null
    $this->render("home/index");
    $this->render(["template" => "home/index"]);
    $this->render(["template" => "home/index", "locals" => null]);
    $this->render(["template" => "home/index", "layout" => "home"]);
    $this->render(["template" => "home/index", "layout" => "home", "locals" => null]);
    $this->render(["view" => "home"]);
    $this->render(["action" => "index"]);
    $this->render(["layout" => "home"]);
    $this->render(["view" => "home", "action" => "index"]);
    $this->render(["view" => "home", "action" => "index", "locals" => null]);
    $this->render(["view" => "home", "action" => "index", "layout" => "home"]);
    $this->render(["view" => "home", "action" => "index", "layout" => "home", "locals" = null]);

    // DEFAULT LAYOUT: home, VIEW: home, ACTION: index, DEFAULT LOCALS: null
    $this->render("home/index");
    $this->render(["template" => "home/index"]);

    // DEFAULT LAYOUT: home, VIEW: home, ACTION: show, DEFAULT LOCALS: null
    $this->render("home/show");
    like $this->render(["template" => "home/show"]);

    // DEFAULT LAYOUT: home, VIEW: admin, ACTION: show, DEFAULT LOCALS: null
    $this->render("admin/show");
    $this->render(["template" => "admin/show"]);
  }
}
```

> `file`

Sadece `locals` ayar anahtarı ile kullanılabilir.

```php
class HomeController extends ApplicationController {

  public function index() {

    // include locals and this file
    // example file path = "app/views/home/users/show.php"

    // DEFAULT LOCALS: null
    $this->render(["file" => "app/views/home/users/show.php"]);

    // LOCALS: ( $fist_name : "Gökhan", $last_name : "Demir" )
    $this->render(["file" => "app/views/home/users/show.php", "locals" => ["fist_name" => "Gökhan", "last_name" => "Demir"]);
  }

}
```

> `partial`

Sadece `locals` ayar anahtarı ile kullanılabilir.

```php
class HomeController extends ApplicationController {

  public function index() {

    // include locals and this file "_show.php" on VIEW path
    // example file : app/views/home/users/_show.php

    // DEFAULT LOCALS: null
    $this->render(["partial" => "home/users/show"]);

    // LOCALS: ( $fist_name : "Gökhan", $last_name : "Demir" )
    $this->render(["partial" => "home/users/show", "locals" => "locals" => ["fist_name" => "Gökhan", "last_name" => "Demir"]]);
  }

}
```

> `text`

Diğer tüm ayarları pas geçer. Bu ayar genelde Ajax fonksiyonların kullanımı içindir.

```php
class HomeController extends ApplicationController {

  public function index() {
    $this->render(["text" => "Hello World"]);
  }

}
```

###### Response Options

> `content_type` [= text/html]

Dönen verinin içerik tipini belirler. (Ör.: text, json, xml gibi)

```php
class HomeController extends ApplicationController {

  public function index() {

    $this->render("home/index", ["content_type" => "text/html"]);
    $this->render(["template" => "home/index"], ["content_type" => "text/html"]);

    $list = [
    "state" : "OK",
    "message" : "Record Saved!"
    ];
    $this->render(["text" => json_encode($list)], ["content_type" => "application/json"]);
  }
}
```

> `status_code` [= 200]

Dönen verinin durum kodunu belirler. (Ör.: text, json, xml gibi)

```php
class HomeController extends ApplicationController {

  public function create() {

    $this->render("home/show", ["content_type" => "text/html", "status_code" => 201]);
  }
}
```

> `headers`

Veri verilmeden önce eklenecek başlığı belirler.

Uygulama ile gelen varsayılan güvenli başlıklar :

```php
  const DEFAULTHEADERS = [
    'X-Frame-Options' => 'SAMEORIGIN',
    'X-XSS-Protection' => '1; mode=block',
    'X-Content-Type-Options' => 'nosniff',
    'X-Download-Options' => 'noopen',
    'X-Permitted-Cross-Domain-Policies' => 'none',
    'Referrer-Policy' => 'strict-origin-when-cross-origin'
  ];
```

```php
class HomeController extends ApplicationController {

  public function create() {

    $this->render("home/show", ["content_type" => "text/html", "status_code" => 201, "headers" => ["Strict-Transport-Security" => "max-age=16070400"]]);
  }
}
```

##### `redirect_to` ($url)

`render` fonksiyonuna göre farkı `Router` üzerinden normal bir istek gibi kontrolü **yapılan** , ilgili `Controller` ve `View` akışı **olan** istektir.

Örneğin aşağıda `/` veya `/home` gibi isteklerin `home#home` olarak `Controller#action` fonksiyonuna gittiği buradan da tekrar bir `/home/index` isteği geldiği verilmektedir.

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("", "home#home"); // or root("home#home"),
  get("home", "home#home");
  get("home/index");
});
```

> `app/controllers/HomeController.php`

```php
class HomeController extends ApplicationController {
  public function home() {
    return $this->redirect_to("home/index");
  }
  public function index() {}
}
```

> `app/views/home/index.php`

```php
<h1> Home#Index </h1>
```

##### `send_data` ($content, $filename, $content_type = [= application/octet-stream])

Gönderdiğiniz veriyi (örneğin, bir PDF dosyası) kaydetmesi için tetiklemek isterseniz, bir dosya ismi ve içeriğini girerek kullanabilirsiniz.

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("home/index");
});
```

> `app/controllers/HomeController.php`

```php
class HomeController extends ApplicationController {
  public function index() {
    return $this->send_data("Bu bir TEXT dosya içeriğidir.", "bilgi.txt");
    // return $this->send_data("Bu bir TEXT dosya içeriğidir.", "bilgi.txt", "text/plain");
  }
}
```

#### Options

##### `helpers`

Daha ayrıntılı bilgi için `Helpers` kısmına bakınız.

##### `before_actions`

Before Action (`protected $before_actions`) özelliği, `app/controller/*.php` dosyası içerisinde her çalışacak get/post fonksiyonları için önceden çalışacak fonksiyonları belirtmeye yarayan özelliktir. Özelliğin etkisini ayarlamak için aşağıdaki 3 şekilde kullanılabilir.

> options : `except`, `only`

1. `except` anahtarı ile nerelerde çalışmayacağını

2. `only` anahtarı ile nerelerde çalışacağını

3. Anahtar yok ise her yerde çalışacağını

```php
class HomeController extends ApplicationController {

  protected $before_actions = [
    ["login", "except" => ["login", "index"]],
    ["notice_clear", "only" => ["index"]],
    ["every_time"]
  ];

  public function index() {
    echo "HomeIndex : Anasayfa (bu işlem için login fonksiyonu çalışmaz, notice_clear ve every_time çalışır)";
  }

  public function login() {
    echo "Home#Login : Her işlem öncesi login oluyoruz. (get/post için /home/login, /home/index hariç)";
  }

  public function notice_clear() {
    echo "Home#NoticeClear : Duyular silindi. (get/post için sadece /home/index'de çalışır)";
  }

  public function every_time() {
    echo "Home#EveryTime : Her zaman get/post öncesi çalışırım.";
  }
```

##### `after_actions`

After Action (`protected $after_actions`) özelliği, `app/controller/*.php` dosyası içerisinde her çalışacak get/post fonksiyonları için sonradan çalışacak fonksiyonları belirtmeye yarayan özelliktir. Özelliğin etkisini ayarlamak için aşağıdaki 3 şekilde kullanılabilir.

> options : `except`, `only`

1. `except` anahtarı ile nerelerde çalışmayacağını

2. `only` anahtarı ile nerelerde çalışacağını

3. Anahtar yok ise her yerde çalışacağını

> `config/routes.php`

```php
ApplicationRoutes::draw(function() {
  get("admin/home");
  get("admin/login");
  post("admin/login");
});
```

> `app/controllers/AdminController.php`

```php
class AdminController extends ApplicationController {

  protected $before_actions = [
  ["require_login", "except" => ["login", "logout"]]
  ];

  public function login() {

    if (isset($_SESSION["admin"]))
      return $this->redirect_to("admin/index");

    if (isset($_POST["username"]) and isset($_POST["password"])) {

      if ($user = User::unique(["username" => $_POST["username"], "password" => md5($_POST["password"])])) {

        $_SESSION["success"] = "Admin sayfasına hoş geldiniz";
        $_SESSION["full_name"] = "$user->first_name $user->last_name";
        $_SESSION["admininfo"] = $user;
        $_SESSION["admin"] = true;

        return $this->render("admin/index");

      } else {

        $_SESSION["danger"] = "Oops! İsminiz veya şifreniz yanlış, belki de bunlardan sadece biri yanlıştır?";

      }
    }

    return $this->render(["layout" => "default"]);
  }

  // public function index() {} // OPTIONAL

  public function logout() {
    if (isset($_SESSION["admin"]))
      session_destroy();
    return $this->redirect_to("admin/login");
  }

  public function require_login() {
    if (!isset($_SESSION["admin"])) {
      $_SESSION["warning"] = "Lütfen hesabınıza giriş yapın!";
      return $this->redirect_to("admin/login");
    }
  }
}
```

> `app/views/admin/login.php`

```html
<div class="row">
  <div class="col-xs-3">
    <img src="/app/assets/img/default.png" class="img-thumbnail" />
  </div>
  <div class="col-xs-9">
    <form class="login-form" action="/admin/login" accept-charset="UTF-8" method="post">
      <input type="text" placeholder="Kullanıcı Adı" class="form-control" size="50" name="username" id="username" />
      <input type="password" placeholder="Parola" class="form-control" size="50" name="password" id="password" />
      <button type="submit" class="btn btn-primary" style="width:100%">SİSTEME GİRİŞ</button>
    </form>
  </div>
</div>
```

> `app/views/admin/home.php`

```php
<h1> Admin#Home </h1>
```

> `app/views/layouts/admin.php`

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="tr" lang="tr">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title></title>
</head>
<body>
  <?= $yield; ?>
</body>
</html>
```

### Views (`app/views/DIRECTORY/*.php`)

---

Yönlendirme dosyasında tanımlı olan (`config/routes.php`) her `get` veya `post` yönlendirmeleri için de yönlendirilen `controller` ve `action` adlarını alarak, view dosyasını (`app/views/CONTROLLER/ACTION.php`) layout dosyası (`app/views/layouts/CONTROLLER.php`) içerisine `<?= $yield; ?>` değişken kısmına gömülür ve görüntülenir.

> `app/views/DIRECTORY/*.php`

```html
<h1> Hello World </h1>
```

> `app/views/layouts/DIRECTORY.php`

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="tr" lang="tr">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title></title>
</head>
<body>
  <?= $yield; ?>
</body>
</html>
```

- Methods

> `render`

#### Methods

##### `render` ($view_options = [])

`render` methodu için `Controllers` kısmındaki,
- `Controllers#render#view_options` özelliği kullanılabilir.
- `Controllers#render#response_options` özelliği **kullanılamaz.**
- Görünüm dosyalarının içerisinde (`html` içerikli dosyalarının) `<?= render(); ?>` şeklinde kullanılmalıdır.

Daha ayrıntılı bilgi için `Controllers#render#view_options` kısmına bakınız.

### Model (`app/models/TABLE.php`)

---

Her hazırlanan `Tablo` kullanılırken,

1. Her tablo isminin harfleri küçük **olmalıdır**. (Ör.: user, agenda, page, product)
2. Her tablo `id` değerine sahip olmalı ve `auto_increment` **olmalıdır**.
3. Her tablo sütunlarının(`id` hariç) varsayılan değeri `NULL` **olmalıdır**.

Her hazırlanan `Model` kullanılırken,

1. Her tablonun bir modeli olmak **zorundadır**.
2. Her model adının ilk harfi büyük olmak **zorundadır**.  (Ör.: tablo: `user` ise `User` olmalıdır.)

> `app/models/TABLE.php`
`example: app/models/User.php`

Aşağıdaki örnekte bir tabloda var olan `id`, `first_name`, `last_name` sütunları vardır. Var olmayan `full_name` isimli sütun oluşturulmuş, o anki kaydın `first_name` ve `last_name` birleştirilmiş halini döneceği belirlenerek modele eklenmiştir.

```php
// user ["id", "first_name", "last_name"]
// 1, Gökhan, Demir
// 2, Gökçe, Demir

class User extends ApplicationModel {

  public function full_name() {
    return $this->first_name . " " . $this->last_name;
  }

}
```

```php
$user = User::find(1);
echo $user->full_name();
// Gökhan Demir
```

- Query Kick Method (static)

> `load`

- Query Load Methods (public)

> `select`, `where`, `or_where`, `joins`, `order`, `group`, `limit`, `offset`

- Query Fetch Methods (public)

> `get`, `get_all`, `pluck`, `count`, `update_all`, `delete_all`, `first`, `last`

- Query Helper Methods (static) [alias]

> `all`, `unique`, `find`, `find_all`, `exists`, `update`, `delete`

- Model Methods

> `draft`, `create`, `save`, `destroy`

#### Create Methods

>  `draft`, `create`

##### `draft` ([$field1 => $value1, ...])

`create` fonksiyonundan farkı verilen sütunlara göre(verilirse) taslak bir model nesnesi oluşturur. Ancak veritabanında yeni bir kayıt oluşturmaz.

```php
// Ör. 1:

$user = User::draft();
$user->first_name = "Gökhan";
$user->save(); // otomatik id alır
print_r($user);
```

```php
// Ör. 2:

$user = User::draft(["first_name" => "Gökhan"])->save(); // otomatik id alır
print_r($user);
```

##### `create` ([$field1 => $value1, ...])

``` php
$user = User::create(["first_name" => "Gökhan"]);
print_r($user);
```

#### Read Methods

> `load`, `select`, `where`, `or_where`, `order`, `group`, `limit`, `get`, `get_all`, `pluck`, `count`, `joins`, `find`, `find_all`, `all`, `first`, `last`

##### `load` ()

- With `get`

```php
// Ör. 1:

$user = User::load()->get();
// SELECT * FROM user LIMIT 1

echo $user->first_name;
```

- With `get_all`

```php
// Ör. 2:

$users = User::load()->get_all();
// SELECT * FROM user

foreach ($users as $user)
  echo $user->first_name;
```

##### `select` ("table.field1", ...)

 Tablodan her kayıt bir sınıfa yüklenirken sütun ismi olarak `id` otomatik olarak eklenmektedir.

- Simple

```php
// Ör. 1:

// user ["id", "first_name", "last_name"]
// 1, Gökhan, Demir
// 2, Gökhan, Arıoğlu

$users = User::load()
           ->select("last_name") // or ->select("user.id", "user.last_name")
           ->get_all();

foreach ($users as $user)
  echo "$user->id, $user->last_name";

// 1, Demir
// 2, Arıoğlu
```

- With `joins`

`joins` kullanılıyor ise `select` işleminde ilişki kurulan tabloya erişimde tablo ismi yazılmalıdır. (Ör.: address.content)
Ayrıca  `joins` işleminde tüm sütunlar otomatik gelmektedir, bundan dolayı istediğiniz bir alan var ise `select` işlemini `joins`den sonra kullanılmalıdır.

```php
// Ör. 2:

// user ["id", "first_name", "last_name"]
// address ["id", "phone", "user_id"]

$users = User::load()
           ->joins("address")
           ->select("user.first_name", "user.last_name", "address.phone")
           ->get_all();

foreach ($users as $user)
  echo "$user->first_name, $user->phone";
```

##### `where`
##### ($key, $value, $mark={"=", "!=", ">", "<", ">=", "<=", "LIKE", "NOT LIKE", "IN", "NOT IN", "BETWEEN", "NOT BETWEEN"}, $logic={"AND", "OR"})
or
##### ($key, $mark={"NULL", "IS NULL", "IS NOT NULL"}, $logic={"AND", "OR"})

defaults: mark="=", logic="AND"

###### `=`, `!=`, `>`, `<`, `>=`, `<=`

```php
$users = User::load()->where("first_name", "Gökhan")->get_all();
$users = User::load()->where("first_name", "Gökhan", "=")->get_all();
// SELECT * FROM user WHERE first_name = 'Gökhan';

$users = User::load()->where("age", 25, "<>")->get_all();
// SELECT * FROM user WHERE age <> 25;

$users = User::load()->where("age", 25, ">")->get_all();
// SELECT * FROM user WHERE age > 25;

$users = User::load()->where("age", 25, "<")->get_all();
// SELECT * FROM user WHERE age < 25;

$users = User::load()->where("age", 25, ">=")->get_all();
// SELECT * FROM user WHERE age >= 25;

$users = User::load()->where("age", 25, "<=")->get_all();
// SELECT * FROM user WHERE age <= 25;
```

###### `IS NULL`, `IS NOT NULL`

```php
$users = User::load()->where("email", NULL)->get_all();
$users = User::load()->where("email", "IS NULL")->get_all();
// SELECT * FROM user WHERE email IS NULL;
$users = User::load()->where("email", "IS NOT NULL")->get_all();
// SELECT * FROM user WHERE email IS NOT NULL;
```

###### `LIKE`, `NOT LIKE`

```php
$users = User::load()->where("email", "%.com.tr", "LIKE")->get_all();
// SELECT * FROM user WHERE email LIKE '%.com.tr';
$users = User::load()->where("email", "%.com.tr", "NOT LIKE")->get_all();
// SELECT * FROM user WHERE email NOT LIKE '%.com.tr';
```

###### `IN`, `NOT IN`

```php
$users = User::load()->where("id", [1, 2, 3], "IN")->get_all();
// SELECT * FROM user WHERE id IN (1, 2, 3);
$users = User::load()->where("id", [1, 2, 3], "NOT IN")->get_all();
// SELECT * FROM user WHERE id NOT IN (1, 2, 3)
```

###### `BETWEEN`, `NOT BETWEEN`

```php
$users = User::load()->where("created_at", ["2016-12-01", "2016-13-01"], "BETWEEN")->get_all();
// SELECT * FROM user WHERE created_at BETWEEN "2016-12-01" AND "2016-13-01";
$users = User::load()->where("created_at", ["2016-12-01", "2016-13-01"], "NOT BETWEEN")->get_all();
// SELECT * FROM user WHERE created_at NOT BETWEEN "2016-12-01" AND "2016-13-01";
```

##### `or_where` ($field, $value, $mark="=")

defaults: mark="="

only logic key: `OR`

```php
// where($field, $value, $mark, "OR")
$users = User::load()->where("first_name", "Gökhan")->or_where("last_name", "Demir")->get_all();
$users = User::load()->where("first_name", "Gökhan", "=", "AND")->where("last_name", "Demir", "=", "OR")->get_all();
// SELECT * FROM user WHERE first_name = 'Gökhan' OR last_name = 'Demir';
```

##### `order` ($field, $sort_type={"DESC", "ASC"})

defaults: sort_type="ASC"

- Simple

```php

$users = User::load()
           ->order("first_name") // or ->order("first_name", "ASC")
           ->get_all();

foreach ($users as $user)
  echo $user->first_name;
```

- Multiple

```php
$users = User::load()
           ->order("first_name")
           ->order("last_name", "DESC")
           ->get_all();

foreach ($users as $user)
  echo $user->first_name;
```

##### `group` ("table.field1", ...)

- Simple

Bir sütun seçilip ve seçilmeyen sütunlar gösterilmeye çalışılınırsa ilk bulduğu kaydı getirdiği için ilk kaydın da  sütunlarını getirmektedir. Bu `GROUP BY`ın  olağan sonucudur.

```php
// Ör.: 1

// user ["id", "first_name", "last_name"]
// 1, Gökhan, Demir
// 2, Gökhan, Demir
// 3, Gökhan, Arıoğlu
// 4, Gökhan, Seven
// 5, Gökçe, Demir
// 6, Gökçe, Arıoğlu

$users = User::load()
           ->group("first_name") // or ->group("user.first_name")
           ->get_all();

foreach ($users as $user)
  echo "$user->id, $user->first_name, $user->last_name";

// 1, Gökhan, Demir
// 4, Gökçe, Demir
```

- Simple with `count`

```php
// Ör.: 2

// user ["id", "first_name", "last_name"]
// 1, Gökhan, Demir
// 2, Gökhan, Demir
// 3, Gökhan, Arıoğlu
// 4, Gökhan, Seven
// 5, Gökçe, Demir
// 6, Gökçe, Arıoğlu

$user_count = User::load()
                ->group("first_name") // or ->group("user.first_name")
                ->count();

/*
[
 ["First_name" => "Gökhan", "count(*)" => 4],
 ["first_name" => "Gökçe", "count(*)" => 2]
]
*/

foreach ($user_count as $user_fields)
  echo $user_fields["count(*)"] . " : " . $user_fields["first_name"];

// 4 : Gökhan
// 2 : Gökçe
```

- Multiple
```php
// Ör.: 2

// user ["id", "first_name", "last_name"]
// 1, Gökhan, Demir
// 2, Gökhan, Demir
// 3, Gökhan, Arıoğlu
// 4, Gökhan, Seven
// 5, Gökçe, Demir
// 6, Gökçe, Arıoğlu

$users = User::load()
           ->where("first_name", "Gökhan")
           ->group("first_name", "last_name")
           ->get_all();

foreach ($users as $user)
  echo "$user->id, $user->first_name, $user->last_name";

// 1, Gökhan, Demir
// 3, Gökhan, Arıoğlu
// 4, Gökhan, Seven
```

- Multiple with `count`

```php
// Ör.: 1

// user ["id", "first_name", "last_name"]
// 1, Gökhan, Demir
// 2, Gökhan, Demir
// 3, Gökhan, Arıoğlu
// 4, Gökhan, Seven
// 5, Gökçe, Demir
// 6, Gökçe, Arıoğlu

$user_counts = User::load()
                 ->where("user.first_name", "Gökhan")
                 ->group("user.first_name", "user.last_name")
                 ->count();
/*
[
  ["First_name" => "Gökhan", "last_name" => "Demir", "count(*)" => 2],
  ["First_name" => "Gökhan", "last_name" => "Arıoğlu", "count(*)" => 1],
  ["First_name" => "Gökhan", "last_name" => "Seven", "count(*)" => 1]
]
*/

foreach ($user_counts as $user_fields)
  echo $user_fields["count(*)"] . " : " . $user_fields["first_name"] . " " . $user_fields["last_name"];

// 2 : Gökhan, Demir
// 1 : Gökhan, Arıoğlu
// 1 : Gökhan, Seven
```

- Multiple with `joins`, `count`

```php
// Ör.: 3

// user ["id", "first_name", "last_name"]
// 1, Gökhan, Demir
// 2, Gökhan, Arıoğlu
// 3, Gökçe, Demir
// 4, Gökçe, Arıoğlu

// address ["id", "country_id", "user_id"]
// 1, 1, 1
// 2, 1, 2
// 3, 1, 3
// 4, 2, 4

// country ["id", "name"]
// 1, Mersin
// 2, Samsun

$user_count = User::load()
                ->joins("address")
                ->group("user.first_name", "address.country_id")
                ->count();

/*
[
  ["first_name" => Gökhan, "address_country_id" => 1, "count(*)" => 2],
  ["first_name" => Gökçe, "address_country_id" => 1, "count(*)" => 1],
  ["first_name" => Gökçe, "address_country_id" => 2, "count(*)" => 1]
]
*/

$user_count = User::load()
                ->joins(["address" => "country"])
                ->group("user.first_name", "country.name")
                ->count();

/*
[
  ["first_name" => Gökhan, "country_name" => Mersin, "count(*)" => 2],
  ["first_name" => Gökçe, "country_name" => Mersin, "count(*)" => 1],
  ["first_name" => Gökçe, "country_name" => Samsun, "count(*)" => 1]
]
*/
```

##### `limit` ($limit=1)

defaults: limit=1

```php
$users = User::load()
           ->limit(10)
           ->get_all();

print_r($users);
```

##### `pluck` ($field)

```php
// Ör. 1:

$user_ids = User::load()->pluck("id");
print_r($user_ids);
// [1, 2, 3, 4, 66, 677, 678]
```

```php
// Ör. 2:

$user_firstnames = User::load()->where("last_name", "Demir")->pluck("first_name");
print_r($user_firstnames);
// ["Gökhan", "Göktuğ", "Gökçe", "Gökay", "Atilla", "Altay", "Tarkan", "Başbuğ", "Ülkü"]
```

##### `count` ()

Bu fonksiyon kullanılırken eğer `group` kullanılmamışsa direkt rakamsal sonuç döner, ancak `group` kullanılmışsa dizi döner.

```php
// Ör. 1:

echo User::load()->count();
// 12
```

```php
// Ör. 2:

echo User::load()->where("first_name", "Gökhan")->count();
// 5
```

##### `joins` ($table) or ([$table]) or ([$table1 => $table2]) or ([$table1 => [$table2 => $table3]) or ([$table1 => [$table2, $table3 => [$table4]]])

İlk tablo sütunları hariç join işleminde select çakışmasını önlemek için diğer tablo alan bilgileri `$TABLE_$field` şeklinde gelmektedir. (Ör.: `user.first_name as user_first_name` gibi)
Veriler alınırken eğer ilişki kurulan diğer tabloda ilişik-veri (yabancı anahtar bazlı bir satır) yok ise kayıt getirmeyecektir. Bu `INNER JOIN`in olağan sonucudur.

```php
// Ör. 1:

// category ["id", "name"]
// article ["id", "category_id"]
// like ["id", "article_id"]
// comment ["id", "article_id"]
// tag ["id", "comment_id"]
// document ["id", "category_id"]

$categories = Category::load()->joins("article")->get_all();
/*
SELECT category.id, category.name,
       article.id as article_id,
       article.category_id as article_category_id
FROM category
INNER JOIN article ON article.category_id=category.id;
*/

$categories = Category::load()->joins(["article"])->get_all();
$categories = Category::load()->joins(["article" => "comment"])->get_all();
$categories = Category::load()->joins(["article" => ["comment" => ["tag"]]])->get_all();
$categories = Category::load()->joins(["article" => ["like", "comment" => ["tag"]]])->get_all();
$categories = Category::load()->joins(["document", "article" => ["like", "comment" => ["tag"]]])->get_all();
$categories = Category::load()->joins(["article", "document"])->get_all();
```

```php
// Ör. 2:

// department ["id", "name"]
// user ["id", "department_id", "first_name"]
// address ["id", "user_id", "content"]

$department = Department::load()
                ->joins(["user", "address"])
                ->where("user.id", 1)
                ->select("user.first_name", "department.name", "address.content")
                ->limit(1)
                ->get_all();
print_r($department);
```

##### `unique` ([$field1 => $value1, ...])

```php
$user = User::unique(["username" => "gdemir", "password" => "123456"]);
echo $user->first_name;
```

##### `find` ($id)

```php
$user = User::find(1);
echo $user->first_name;
```

##### `find_all` ([$id1, ...])

```php
$users = User::find_all([1, 2, 3]);
foreach ($users as $user)
  echo $user->first_name;
```

##### `all` ()

```php
$users = User::all();
foreach ($users as $user)
  echo $user->first_name;
```

##### `first` ($count=1)

defaults: count=1

```php
// Ör. 1:

$user = User::first();
echo $user->first_name;
```

```php
// Ör. 2:

$users = User::first(10);
foreach ($users as $user)
  echo $user->first_name;
```

##### `last` ($count=1)

defaults: count=1

```php
// Ör. 1:

$user = User::last();
echo $user->first_name;
```

```php
// Ör. 2:

$users = User::last(10);
foreach ($users as $user)
  echo $user->first_name;
```

##### `exists` ($id)

```php
echo User::exists(1) ? "kayit var" : "kayit yok";
```

#### Update Methods

> `save`, `update`

##### `save` ()

```php
// Ör. 1:

$user = User::unique(["username" => "gdemir", "password" => "123456"]);
$user = User::find(1);
$user = User::load()->get();
$user = User::first();
$user = User::last();
$user->first_name = "Gökhan";
$user->save();

print_r($user);
```

```php
// Ör. 2:

$users = User::find_all([1, 2, 3]);
$users = User::load()->get_all();
$users = User::all();
$users = User::load()
           ->where("first_name", "Gökhan")
           ->select("first_name")
           ->order("id")
           ->limit(10)
           ->get_all();
$users = User::first(10);

foreach ($users as $user) {
  $user->first_name = "Göktuğ";
  $user->save();
}
```

##### `update` ($id, [$field1 => $value1, ...])

```php
// Ör. 1:

User::update(1, ["first_name" => "Gökhan", "last_name" => "Demir"]);
```

```php
// Ör. 2:

$users = User::find_all([1, 2, 3]);
$users = User::load()->get_all();
$users = User::all();
$users = User::load()
           ->where("first_name", "Gökhan")
           ->select("first_name")
           ->order("id")
           ->limit(10)
           ->get_all();
foreach ($users as $user)
  User::update($user->id, ["first_name" => "Göktuğ", "last_name" => "Demir"]);
```

#### Delete Methods

> `destroy`, `delete`, `delete_all`

##### `destroy` ()

```php
$user = User::unique(["username" => "gdemir", "password" => "123456"]);
$user = User::find(1);
$user = User::load()->get();
$user = User::first();
$user = User::last();
$user->destroy();
```

##### `delete` ($id)

```php
User::delete(1);
```

##### `delete_all` ()

```php
User::load()->delete_all();
User::load()->where("first_name", "Gökhan")->delete_all();
User::load()->where("first_name", "Gökhan")->limit(10)->delete_all();
User::load()->limit(10)->delete_all();
```

#### Dependencies

> `$BELONGTABLE->OWNERTABLE`, `$OWNERTABLE->all_of_BELONGTABLE`

##### `$BELONGTABLE->OWNERTABLE`

```php
// department ["id", "name"]
// user ["id", "department_id", "first_name", "last_name"]
// book ["id", "user_id", "name"]

// department
// [1, "Bilgisayar Mühendisliği"]
// [2, "Makine Mühendisliği"]

// user
// [1, 1, "Gökhan", "Demir"]
// [2, 1, "Göktuğ", "Demir"]
// [3, 2, "Göksen", "Demir"]

// book
// [1, 1, "Barak Türkmenlerinin Tarihi"]
// [2, 1, "Oğuz Boyu"]
// [3, 3, "Almila"]

$book = Book::find(1);
// [1, 1, "Barak Türkmenlerinin Tarihi"]

print_r($book->user);
// [1, 1, "Gökhan", "Demir"]

print_r($book->user->department);
// [1, "Bilgisayar Mühendisliği"]

echo "$book->user->department->name $book->user->first_name $book->name";
// "Bilgisayar Mühendisliği Gökhan Barak Türkmenlerinin Tarihi"
```

##### `$OWNERTABLE->all_of_BELONGTABLE`

```php
// user ["id", "department_id", "first_name", "last_name"]
// book ["id", "user_id", "name"]

// user
// [1, 1, "Gökhan", "Demir"]
// [2, 1, "Göktuğ", "Demir"]
// [3, 2, "Göksen", "Demir"]

// book
// [1, 1, "Barak Türkmenlerinin Tarihi"]
// [2, 1, "Oğuz Boyu"]
// [3, 2, "Kımız"]
// [4, 3, "Almila"]

$user = User::find(1);
$books = $user->all_of_book;
foreach ($books as $book)
  echo $book->name;
```

### Helpers (`app/helpers/*.php`)

---

Helpers `app/helpers/*Helper.php` şeklinde tanımlanan sınıfları proje için gerekli görüldüğü yerlerde projeye dahil eder. Helpers özelliğini  `Controller` ve `Mailer` sınıfları kullanmaktadır.

```
// Ör.: dosya : `app/helpers/PasswordHelper.php`
class PasswordHelper {
  public static function generate($length) {
    // rastgele bir parola belirle
    $alphabet = "abcdefghijklmnopqrstuwxyzABC0123456789";
    for ($i = 0; $i < $length; $i++) {
      $random_password[$i] = $alphabet[rand(0, strlen($alphabet) - 1)];
    }
    return implode("", $random_password);
  }
}
```

- Options

> `$FILE`, `all`

#### Options

##### `$FILE`

İstenilen helper sınıflarını projeye dahil eder.

```php
class HomeController extends ApplicationController {

  protected $helpers = ["Password"];

  public function index() {
    echo "random password : " . PasswordHelper::generate(10);
  }
}
```

##### `all`

`app/helpers/*` altındaki tüm helper sınıflarını projeye dahil eder.

```php
class HomeController extends ApplicationController {

  protected $helpers = "all";

  public function index() {
    echo "random string   : " . StringHelper::generate(10);
    echo "random password : " . PasswordHelper::generate(10);
  }
}
```

### Mailer (`app/mailers/*.php`)

---

Her mailer dosyası ile sınıfının ismi aynı **olmalıdır** ve sistemin olan `ApplicationMailer` sınıfından miras alır.

```php
// Ör.: dosya : `app/mailers/PasswordMailer.php`
class PasswordMailer extends ApplicationMailer {
}
```

Mailer sınıf olarak `PHPMailer`i kullanmaktadır ve yapı olarak Controller sınıfındaki gibi benzeri görev yapmaktadır. Ayarlama olarak `helper`, `before_actions`, `after_actions` yardımcı özelliklerini kullanabilme imkanı vermektedir.

Her hazırlanan Mailer sınıfı kullanırken,

1. Sınıf `app/mailers/*.php` isminde tanımlanmalıdır.
2. Sınıf içerisinde tanımlanan fonksiyonlarda `mail` fonksiyonu kullanılmak **zorunludur**.
3. Layout olarak **zorunlu** `app/views/layouts/mailer.php` dosyasını kullanmaktadır.
4. View olarak **zorunlu** `app/views/mail` dizinini kullanmaktadır. İstenilen actiona göre `app/views/mail/ACTION.php` dosyası tanımlanması gerekir.

- Kick Method

> `delivery`

- Methods

> `mail`

- Options

> `helpers`, `before_actions`, `after_actions`

#### Kick Method

##### `delivery` ($action, [$param1, ...])

1. `$action` parametresi olarak oluşturduğunuz `app/mailers/*Mailer.php` sınıfı içersindeki method ismi yazılır.
2. `$action` adındaki oluşturduğunu method eğer bir veri alacak şekilde tanımlandıysa bu veriler `[$param1, ...]` şeklinde gönderilir.
3. `delivery` methodu ilişkili(`before_actions` ve `after_actions`) methodlarla çalışması sonucunda eğer mail gönderiminde hata alıyorsa hangi **action**da hangi hata dönüyor şeklinde bir dizi döndürür. Ör. ["action1" => "error1", "action2" => "error2", ...]

> `app/controllers/HomeController.php`

```php
class HomeController extends ApplicationController {
  public function index() {
  
    $errors = PasswordMailer::delivery("reset");
    
    /* print_r($errors);
    [
    "reset" => "SMTP connect() failed. https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting error",
    "info" => "ERVER -> CLIENT:SMTP NOTICE: EOF caught while checking if connected Connection: closed SMTP Error: Could not connect to SMTP host. SMTP connect() failed. https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting"
    ]
    */
    
    $errors = PasswordMailer::delivery("reset2", ["m930fj039fj039j", "gdemir.me", "mail@gdemir.me", "Gökhan Demir"]);
    
    /* print_r($errors);
    [
    "reset" => "SMTP connect() failed. https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting error",
    "info" => "ERVER -> CLIENT:SMTP NOTICE: EOF caught while checking if connected Connection: closed SMTP Error: Could not connect to SMTP host. SMTP connect() failed. https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting"
    ]
    */
  }
}
```

> `app/mailers/PasswordMailer.php`

```php
class PasswordMailer extends ApplicationMailer {

  protected $after_actions = [["info"]];

  public function info() {
    if (isset($this->email) && isset($this->fullname)) {
      $this->mail([
        "to" => [$this->email => $this->fullname],
        "subject" => "Güçlü Şifre İçin Öneriler"
      ]);
    }
  }

  public function reset() {
    $this->code = "ab234c2589de345fgAASD6";
    $this->site_url = "gdemir.me";
    $this->mail([
      "to" => ["mail@gdemir.me" => "Gökhan Demir"],
      "subject" => "[Admin] Please reset your password"
      ]);
  }

  public function reset2($random_code, $site_url, $email, $fullname) {
    $this->code = $random_code;
    $this->site_url = $site_url;
    $this->mail([
      "to" => [$email => $fullname],
      "subject" => "[Admin] Please reset your password"
      ]);
  }
}
```

#### Methods

##### `mail` (["to" => [$email1 => $name1, ...], "subject" => $subject])

> options : `to`, `subject`

> `app/controllers/HomeController.php`

```php
class HomeController extends ApplicationController {
  public function index() {
    PasswordMailer::delivery("reset");
    PasswordMailer::delivery("reset2", ["m930fj039fj039j", "gdemir.me"]);
  }
}
```

> `app/mailers/UserMailer.php`

```php
class UserMailer extends ApplicationMailer {

  protected $after_actions = [["info"]];

  protected $before_actions = [["notice"]];

  public function notice() {
    $this->mail([
      "to" => ["gdemir@bil.omu.edu.tr" => "Gökhan Demir"],
      "subject" => "1 Kullanıcı Şifre Sıfırlama Talebinde Bulundu"
      ]);
  }

  public function info() {
    if (isset($this->email) && isset($this->fullname)) {
      $this->mail([
        "to" => [$this->email => $this->fullname],
        "subject" => "Güçlü Şifre İçin Öneriler"
      ]);
    }
  }

  public function reset() {
    $this->code = "ab234c2589de345fgAASD6";
    $this->site_url = "gdemir.me";
    $this->mail([
      "to" => ["mail@gdemir.me" => "Gökhan Demir"],
      "subject" => "[Admin] Please reset your password"
      ]);
  }

  public function reset2($random_code, $site_url, $email, $fullname) {
    $this->code = $random_code;
    $this->site_url = $site_url;
    $this->email = $email;
    $this->fullname = $fullname;
    $this->mail([
      "to" => [$this->email => $this->fullname],
      "subject" => "[Admin] Please reset your password"
      ]);
  }
}
```

> `app/views/layouts/mailer.php`

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="tr" lang="tr">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title></title>
  <link href="" rel="alternate" title="" type="application/atom+xml" />
  <link rel="shortcut icon" href="/favicon.ico">
  <link rel="stylesheet" href="/app/assets/css/syntax.css" type="text/css" />
  <link href='http://fonts.googleapis.com/css?family=Monda' rel='stylesheet' type='text/css'>

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="/app/assets/js/html5shiv.min.js"></script>
  <script src="/app/assets/js/respond.min.js"></script>
  <![endif]-->

  <script src="http://code.jquery.com/jquery.js"></script>
  <script src="/app/assets/js/bootstrap.min.js"></script>
</head>
<body>
  <div class="container" style="width:365px; min-height:200px; margin-top: 8%;">
    <?= $yield; ?>
  </div>
</body>
</html>
```

> `app/views/mail/password/reset.php`

```html
Sistem şifrenizi kaybettiğinizi duyduk. Üzgünüm!<br/><br/>
Endişelenme! Parolanızı sıfırlamak için 1 saat içinde aşağıdaki bağlantıyı kullanabilirsiniz:<br/><br/>
<a href='http://$_site_url/admin/password_reset/$code'>http://$_site_url/admin/password_reset/$code</a>
```

> `app/views/mail/password/reset2.php`

```html
Sistem şifrenizi kaybettiğinizi duyduk. Üzgünüm!<br/><br/>
Endişelenme! Parolanızı sıfırlamak için 1 saat içinde aşağıdaki bağlantıyı kullanabilirsiniz:<br/><br/>
<a href='http://$_site_url/admin/password_reset/$code'>http://$_site_url/admin/password_reset/$code</a>
```

> `app/views/mail/password/info.php`

```html
<code>UYARI</code>:
<i class="text-info">
  <ul class="col-sm-offset-1">
    <li>Şifreniz en az 8 karakterden oluşmalıdır</li>
    <li>Büyük, küçük harfler ve rakamların her biri en az 1 defa kullanılmalıdır</li>
    <li>"?, @, !, #, %, +, -, *, %" gibi özel karakterler en az 1 defa kullanılmalıdır</li>
  </ul>
</i>
```

> `app/views/mail/password/notice.php`

```html
<code>BİLDİRİM</code>:
<hr>
Web sayfasında 1 kişi şifre değişikliği talebinde bulundu. <br/>
<b>Tarih :</b> <?= date("Y-m-d H:i:s"); ?>
```

#### Options

##### `helpers`, `before_actions`, `after_actions`

Fonksiyonları Controller'daki gibi tüm özellikleri ile kullanılabilir. Daha ayrıntılı bilgi için `Controller#options` kısmına bakınız.

### Seeds (`db/seeds.php`)

---

Uygulamaya her URL isteği geldiğin ilk olarak çalışan betiktir. Örnekleme kayıtları oluşturmak veya loglama için kullanılabilir.

> `db/seeds.php` (database seeds file)

```php
if (User::load()->count() == 0) {
  User::create(["first_name" => "Gökhan", "last_name" => "Demir", "username" => "gdemir",  "password" => "123456"]);
  User::create(["first_name" => "Gökçe",  "last_name" => "Demir", "username" => "gcdemir", "password" => "123456"]);
  User::create(["first_name" => "Göktuğ", "last_name" => "Demir", "username" => "gtdemir", "password" => "123456"]);
  User::create(["first_name" => "Atilla", "last_name" => "Demir", "username" => "ademir",  "password" => "123456"]);
}
```

### I18n (`config/locales/LOCALE.php`)

---

Yapılandırma dizinindeki diller kısmında (`config/locales/`) tanımlı olan dil dosyaları (Ör.: `config/locales/tr.php`, `config/locales/en.php`) üzerinden erişim, çeviri, o anki dilin ne olduğu gibi işlemlerin yapılması hakkında kullanılan fonksiyonlar bu bölümde anlatılmıştır.

- Methods

> `locale`, `get_locale`, `translate`

#### Methods

##### `locale` ($locale)

Çeviri kelimeleri (`config/locales/tr.php` veya `config/locales/en.php` gibi dosyalar dizi olarak `$_SESSION["_i18n"]` üzerine yüklenir.) proje başlangıcında `config/application.ini` dosyası içerisinde `locale` değişkenine ile atanabilir veya projenin herhangi bir aşamasında aşağıdaki gibi atanabilir/değiştirilebilir.

```php
ApplicationI18n::locale("tr");
```

##### `get_locale` ()

O an seçili olan dilin hangisi olduğunu anlamak için kullanılan fonksiyondur.

```php
// Ör. 1:

ApplicationI18n::get_locale();
// tr
```

```php
// Ör. 2:

ApplicationI18n::get_locale();
// en

```

##### `translate` ($path, $parameters = {NULL, [$field1 => value1, ...]})

- Simple

Çevirisi yapılacak bir kelime dizini o an hangi dil yüklü ise ona göre çeviri yapmak için aşağıdaki gibi kullanılır.

```php
ApplicationI18n::translate("home.about_us");
```

bu fonksiyonu daha kolay kullanmak için alias olarak tanımlı `t` fonksiyonu ile erişilebilir.

```php
t("home.about_us");
```

Buradaki çeviri ayarlarının kaydedildiği yer `config/locales/*` dizinidir. Daha ayrıntılı bilgi için `Configurations#config/locales/LANGUAGE.php` kısmına bakınız.

- Lazy (Tembel)

Her template dosyasının bir title vermek isterseniz ve buna kolayca erişmek istenirse kullanılır. Ör.: Dizin Yapısı aşağıdaki gibi olan templateler için

```php
views/home/index.php
views/home/about_us.php
views/home/contact.php
views/home/writerpage/search.php
views/home/writerpage/show.php
config/tr.php içerisinde böyle bir tanımlama yapılabilir.
```

```php
<?php
return [
  "home" => [
    "index" => ["title" => "Popüler"],
    "about_us" => ["title" => "Hakkımızda"],
    "contact" => ["title" => "Bize Ulaşın"],
    "writerpage" => [
      "search" => ["title" => "Yazar Ara"],
      "show" => ["title" => "Yazar Göster"]
    ]
  ]
];
?>
```

Bunu kullanmak için de layout/home.php içerisinde şöyle belirtmek yeterlidir.

```php
<title><?= t(".title"); ?></title>
```

- With Parameter

Bu fonksiyona parametre yollayarak translate metinlerine değişken hale getirebilirsiniz.

Örneğin `config/tr.php` içerisinde parametre belirtiyoruz.

```php
return [
  "home" => [
    "show" => [
      "title" => "Yazar Göster - {writer_name}",
      "success" => "Yazar Gösterildi - {writer_name}"
  ]
];
```

`app/controllers/HomeController.php` içerisinde veriyi atıyoruz.

```php
class HomeController {
  function show {
    $name = "Hüseyin Nihal Atsız";
    $this->writer_name = $name;
    $_SESSION["success"] = t(".success", $name);
    // $_SESSION["success"] = t("home.show.success", $name);
  }
}
```

`app/views/layouts/home.php` dosyasında veriyi gösteriyoruz.

```php
<title>
  Yazar Göster -
  <?php if (isset($writer_name)) { ?>
  <?= t(".title", ["writer_name" => $writer_name]); ?>
  <?php } else { ?>
  <?= t(".title"); ?>
  <?php } ?>
</title>
```

### Debug

---

Uygulamanın her istek URL geldiğinde Exception, Error, Shutdown(Fatal Error) akışlarını yakalayıp tek sayfada gösterilmesini sağladığını anlatan bölümdür. Eğer yanılmaların gösterilmesi istenmiyorsa `config/application.ini` dosyası içerisinde `debug = false` denilerek kullanıcı bazlı `public/500.html` sayfası gösterilir, ancak log kaydı her şekilde de tutulur.

- Methods

> `exception`, `error`, `shutdown`

#### Methods

##### `exception` (Exception $exception)

```php
throw new Exception("OMG!");
```

veya

```php
ApplicationDebug::exception(new Exception("OMG!"));
```

tarzındaki fonksiyonlar ile yanılmanın bulunduğu sayfayı yakalar ve istisnanın bulunduğu kod satırınının bir kısmını gösterir.

##### `error` ($errno, $error, $file, $line)

```php
ApplicationDebug::error(123123, "Undefined variable: a", "/var/www/html/app/controllers/DefaultController.php", 10);
```

veya

```php
echo $a;
```

gibi tanımlı olmayan değişkenin kullanılma yanılmasını adım adım framework'de hangi dosyalardan hangi satıra kadar olduğunun gösterilmesini sağlar.

##### `shutdown` ()

```
ApplicationDebug::shutdown();
```

veya

ölümcül başka türlü yanılmalarda (sistemin çalışmadığı durumlarda) sistemin ölümcül yanıldığı kısmı adım adım framework'de hangi dosyalardan hangi satıra kadar olduğunun gösterilmesini sağlar. Log dosyasının maximum ulaşabileceği boyutu ayarlar, varsayılan olarak boyut `5242880 byte (5 megabyte)` şeklindedir. Eğer belirlenen boyut aşılırsa dosyaya yazmayı keser. Bu boyut ayarlaması yapıldığında daha önceki boyut ayarlamalarını pas geçer.

### Logger (`tmp/log/*.log`)

---

Sistem mesajları ve verilen mesajları log dosyasına yazmaya yarayan özelliktir. Daha ayrıntılı bilgi için `Configurations#config/logger` kısmına bakınız.

- Methods

> `info`, `warning`, `error`, `fatal`, `debug`

#### Methods

##### `info`, `warning`, `error`, `fatal`, `debug` ($message)

```php
ApplicationLogger::info("bilmek iyidir");
ApplicationLogger::warning("olabilir?");
ApplicationLogger::error("dikkat et");
ApplicationLogger::fatal("cevap vermiyor");
ApplicationLogger::debug("olaylar olaylar");

// tmp/log/production_2017-06-18.log
// bilmek iyidir
// olabilir?
// dikkat et
// cevap vermiyor
// olaylar olaylar
```

### Cacher (`tmp/cache/*.cache`)

---

Belirlediğiniz değişkenleri belli bir mühdet veritabanından değil de dosya olarak tutup bunu tekrar kullanmanıza yarayan özelliktir. Örneğin bir veri durmadan veritabanından çekileceğine, dosyaya yazılıp eğer dosyada varsa dosyadan çek şeklinde bir kod yazılabilir. Bu şekilde veritabanın üzerindeki yük azaltılabilir.

Değişken ismini saklayabilmek için verilen anahtarlara göre  `key` (verilen anahtar)'e göre `md5` ile şifreleyip `tmp/cache/*` dizini üzerinde yazma, okuma, silme, var olduğunu bakma, tamamen silme gibi işlemleri yapılmaktadır.

Yani `/home/users/` sayfasına bir istek geldiğinde `$users` değişkenini şifreleyip `tmp/cache/3290482038.cache` gibi bir dosya üzerine yazar ve bu dosyayı belli bir zaman içerisinde erişimine imkan verir.

```php
// Ör.:
// Eğer `cache`'de `$users` değişkenin
// kaydı var ise oradan al
// kaydı yok ise veritabanından çek ve yeni bir `cache` olarak `$users` verilerini kaydet.

$cachekey = "users";
if (!$users = ApplicationCache::read($cachekey)) {

  $users = User::all();
  ApplicationCache::write($cachekey, $users);
}

foreach ($users as $user)
  echo $user->first_name;
```

- Methods

> `expiration`, `write`, `read`, `delete`, `exist`, `reset`

#### Methods

##### `expiration` ($second = 600000)

Saklanacak verilerin genel olarak ne kadar süre ile tutulacağının ayarlar, veriler varsayılan olarak `600000 saniye (=~7 gün)` süre ile saklanır.

```php
ApplicationCache::expiration(600000);
```

##### `write` ($key, $value)

Saklanacak verilerin `key` (verilen anahtar)'e göre md5 ile şifreleyip belleğe yazar. Bu şekilde farklı bir sayfada kaydettiğiniz aynı anahtar isimli veriler, farklı dosyalar olarak kaydedilmektedir.

```php
$users = User::all();
ApplicationCache::write("users", $users);
```

##### `read` ($key)

Bellekteki veriyi `key` mantığı ile okur, eğer dosyanın süresi geçmişse otomatik olarak siler.

```php
$users = ApplicationCache::read("users");
```

##### `delete` ($key)

`key` mantığına göre bulunan ve var olan dosya süresine bakılmaksızın silinir.

```php
ApplicationCache::delete("users");
```

##### `exists` ($key)

`key` mantığına göre var olmasına bakar.

```php
echo (ApplicationCache::exists("users")) ? "bellekte var" : "bellekte yok";
```

##### `reset` ()

`tmp/cache/*` altındaki tüm saklanan verileri sürelerine bakılmaksızın siler.

```php
ApplicationCache::reset();
```

### Http

---

Api servislerine `GET`, `POST`, `HEAD` methodları ile istek gönderen bir sınıftır.

Uygulama ile gelen varsayılan başlıklar :

```php
const DEFAULTHEADERS = [
  'Content-Type' => 'application/x-www-form-urlencoded'
];
```

Uygulama ile gelen varsayılan ayarlar :

```php
const DEFAULTOPTIONS = [
  'CURLOPT_HEADER' => true,
  'CURLOPT_RETURNTRANSFER' => true
];
```

- Methods

> `head`, `get`, `post`

- Attributes

> `headers`, `options`

- Method Output Attributes

> `status_code`, `content_type`, `headers`, `body`

#### Methods

##### `head` ($url)

Api servisine HEAD isteği yollar. Nitelik olan `headers` ve `options` anahtarlarına veri yüklenmesi zorunda değildir.

```php
$http = new ApplicationHttp();
$response = $http->head("http://api.gdemir.github.io");
print_r($response);
```

##### `get` ($url)

Api servisine GET isteği yollar. Nitelik olan `headers` ve `options` anahtarlarına veri yüklenmesi zorunda değildir.

```php
// Ör. 1:
$http = new ApplicationHttp();
// $http->headers = ["Content-type" => "application/html"];
// $http->options = [];
$response = $http->get("http://api.gdemir.github.io");
echo $response->status_code;
echo $response->content_type;
print_r($response->headers);
echo $response->body; // parçalamak gerekebilir (Ör.: `simplexml_load_string`, `json_decode`)
```

```php
$http = new ApplicationHttp();
// $http->headers = ["Content-type" => "application/html"];
$username = "********";
$password = "********";
$http->options = ["CURLOPT_USERPWD" => $username . ":" . $password]; // Basic Auth for HTTP Authentication | Username: ********, Password: ********
$response = $http->get("https://api.aa.com.tr/abone/discover/tr_TR");
echo $response->status_code;
echo $response->content_type;
$result = json_decode($response->body, true);
// ---

// Ör. 2:
$http = new ApplicationHttp();
// $http->headers = ["Content-type" => "application/html"];
// $http->options = [];
$response = $http->get("http://api.gdemir.github.io");
echo $response->status_code;
echo $response->content_type;
print_r($response->headers);
echo $response->body; // parçalamak gerekebilir (Ör.: `simplexml_load_string`, `json_decode`)
```

##### `post` ($url, $data = [])

Api servisine POST isteği yollar. Nitelik olan `headers` ve `options` anahtarlarına veri yüklenmesi zorunda değildir.
Aşağıdaki örnek MNG kargo entegrosyonu bağlantı testi içindir, test edilen bir örnektir.

```php
// Ör. 1:
$http = new ApplicationHttp();
// $http->headers = [];
// $http->options = ["CURLOPT_SSL_VERIFYPEER" => false];
$response= $http->post("http://service.mngkargo.com.tr/tservis/musterikargosiparis.asmx/Baglanti_Test");

echo $response->status_code;
echo $response->content_type;
print_r($response->headers);
$result = simplexml_load_string($response->body);  // parçalamak gerekebilir (Ör.: `simplexml_load_string`, `json_decode`)
```

```php
// Ör. 2:
$http = new ApplicationHttp();
// $http->headers = [];
// $http->options = ["CURLOPT_SSL_VERIFYPEER" => false];
$response = $http->post("http://service.mngkargo.com.tr/tservis/musterikargosiparis.asmx/SiparisGirisiDetayliV3", $_POST);

echo $response->status_code;
echo $response->content_type;
print_r($response->headers);
$result = simplexml_load_string($response->body);  // parçalamak gerekebilir (Ör.: `simplexml_load_string`, `json_decode`)
```

### Packages (`composer`)

Barak Framework `PHPMailer` kütüphanesini kullanmaktadır. Kendi yazdığınız ya da kullanmak istediğiniz diğer harici kütüphanelerin de dahil edilip kullanılmasına olanak verir. Harici kütüphaneler `composer` paket yöneticisi kullanılarak ya da manuel olarak dosyaların kopyalanması ile dahil edilebilir.

Composer paket yöneticisi kullanarak kütüphane dahil etmek için `require` ve `update` ayar kullanımları vardır.

- Options

> `require`, `update`

#### Options

##### require

Komut satırında `require` anahtarı ile çalıştırmak.

```sh
composer require USER/PACKAGE
```

Ör.:

```sh
composer require google/recaptcha
```

##### update

Ana dizinde bulunan `composer.json` dosyasının `require` anahtar bölümüne eklemek.

```diff
{
    "name": "barak-framework/barak",
    "type": "project",
    "description": "Barak Framework",
    "keywords": ["barak", "turkmen", "framework"],
    "homepage": "http://barak-framework.github.io",
    "license": "MIT",
    "authors": [
        {
            "name": "Gökhan DEMİR",
            "email": "gdemir3327@gmail.com",
            "homepage": "http://gdemir.github.io",
            "role": "Developer"
        }
    ],
+   "require": {
+       "php": ">=5.4.0",
+       "phpmailer/phpmailer": "^5.2"
+   }
}
```

yukarıdaki örnekte olduğu gibi projenin gereksinimlerinde php ve phpmailer gözükmektedir.

Örneğin, `"google/recaptcha": "^1.1"` satırını ekleyip `google/recaptcha` uygulamasını projeye dahil edebiliriz.

```diff
"require": {
    "php": ">=5.4.0",
    "phpmailer/phpmailer": "~5.2",
+   "google/recaptcha": "^1.1"
}
```

Daha sonra aşağıdaki komut çalıştırılmalıdır.

```sh
composer update
```
