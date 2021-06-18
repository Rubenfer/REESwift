# REESwift

REESwift permite integrar de forma sencilla la API de Red Electrica Española (REE) para obtener los precios de la electricidad en tarifas del mercado regulado PVPC y mercado spot.

Si quieres consultar los precios directamente en tu dispositivo, sin necesidad de crear tu propia aplicación, puedes hacerlo con [Precio Luz España](https://apps.apple.com/es/app/precio-luz-españa/id1487330692), disponible para iPhone, iPad, Apple Watch y Mac de forma gratuita. 

1. [Versiones](#versiones)
2. [Integración](#integración)
3. [Uso](#uso)
    - [Obtener precios consumidor](#obtener-precios-consumidor)
    - [Obtener precios mercado spot](#obtener-precios-mercado-spot)
4. [Licencia de uso y contribución con el proyecto](#licencia-de-uso-y-contribución-con-el-proyecto)

## Versiones

Si estás utilizando Xcode 12 o anterior debes utilizar la versión 0.1.x.
Si ya utilizas Xcode 13+ puedes utilizar la versión 1.x.x.

## Integración

Puedes añadir REESwift a tu proyecto a través de Swift Package Manager: https://github.com/Rubenfer/REESwift

## Uso

```swift
import REESwift
```

### Obtener precios consumidor

```swift
func consumerPrices(startDate: Date, endDate: Date, geo: GEO, completion: @escaping (Result<[Value], Error>) -> Void)
func consumerPrices(date: Date, geo: GEO, completion: @escaping (Result<[Value], Error>) -> Void)
func consumerPrices(startDate: Date, endDate: Date, geo: GEO) -> AnyPublisher<[Value], Error>
func consumerPrices(date: Date, geo: GEO) -> AnyPublisher<[Value], Error>
```

### Obtener precios mercado spot

```swift
func spotPrices(startDate: Date, endDate: Date, geo: GEO, completion: @escaping (Result<[Value], Error>) -> Void)
func spotPrices(date: Date, geo: GEO, completion: @escaping (Result<[Value], Error>) -> Void)
func spotPrices(startDate: Date, endDate: Date, geo: GEO) -> AnyPublisher<[Value], Error>
func spotPrices(date: Date, geo: GEO) -> AnyPublisher<[Value], Error>
```

## Licencia de uso y contribución con el proyecto

Este proyecto se encuentra bajo la licencia GNU GPLv3. Antes de utilizarlo, [consulta las limitaciones de dicha licencia](https://github.com/Rubenfer/REESwift/blob/main/LICENSE).

Si deseas contribuir con el proyecto todo Pull request es bienvenido. 
