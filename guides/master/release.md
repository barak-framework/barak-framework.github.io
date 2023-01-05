#### Index.php

- Değişiklik yok

#### Composer

- Değişiklik yok.

### BarakApplication +

- **[Kaldırıldı]**: `_close_option_kernel` fonksiyonun kaldırılması
- **[Kaldırıldı]**: ApplicationFlash özellik değerlerinin kaldırılması

### lib/

#### kernel/

##### Application

- Değişiklik yok

##### ApplicationAlias

- Değişiklik yok

##### ApplicationConfig

- Değişiklik yok.

##### ApplicationController

- **[Değişti]**: Yanıt kodunun varsayılan olan olarak `200` olarak atanması
- **[Onarıldı]**: `$_before_path` üst üste ekleme yapılmıyordu; scope ve path gibi içice dizinlere 
- **[Kaldırıldı]**: ApplicationFlash özellik değerlerinin kaldırılması

##### ApplicationDebug

- Değişiklik yok.

##### ApplicationDispatcher

- Değişiklik yok.

##### ApplicationHelper

- Değişiklik yok.

##### ApplicationI18n

- Değişiklik yok

##### ApplicationLogger
- **[Değişti]**: Path yolu düzeltme
- **[Değişti]**: Sınıf içindeki gizli fonksiyon isim değişikliği
- **[Onarıldı]**: **DRIVERNAMES** sabit dizisi içerisindeki `montly` ifadesinin doğru yazımı olan `mountly` olarak düzeltilmesi

##### ApplicationRequest

- Değişiklik yok.

##### ApplicationResponse

- **[Değişti]**: Yanıtlarda `attachment`(**ek dosya**) değerinin `0` yerine `NULL` olarak değiştirilmesi

##### ApplicationRoute

- Değişiklik yok.

##### ApplicationRoutes

- Değişiklik yok.

##### ApplicationView

- **[Kaldırıldı]**: ApplicationFlash özellik değerlerinin kaldırılması

##### ApplicationFlash -

- **[Kaldırıldı]**: Sınıfın kaldırılması

#### modules/

##### cacher/

###### ApplicationCacher

- **[Eklendi]**: Dosya uzantısı yoktu, dosya uzantısı `.cache` olacak şekilde eklendi.

##### http/

###### ApplicationHttp

- Değişiklik yok.

##### mailer/

###### ApplicationMailer

- **[Eklendi]**: `delivery` methodunun hata olduğunda her `action`a ait stringi dönen string dizisi dönmesi eklenmesi
- **[Değişti]**: Erişim değişkenin değiştirilmesi

##### model/

###### ApplicationDatabase

- Değişiklik yok.

###### ApplicationModel

- Değişiklik yok.

###### ApplicationQuery

- Değişiklik yok.

###### ApplicationSql

- Değişiklik yok.
