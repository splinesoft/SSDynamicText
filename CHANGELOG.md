# SSDynamicText CHANGELOG

## ?.?.?
###### ?

- **(fixed)** Fixed memory leak caused by strong retain cycle in `SSDynamicLabel`, `SSDynamicTextView` and `SSDynamicTextField` classes, [#40](https://github.com/splinesoft/SSDynamicText/issues/40). _([Grubas7](https://github.com/Grubas7))_

## 1.1.0
###### September 26, 2016

- **(fixed)** Fixed IB crash for `SSDynamicButton` subclasses, [#36](https://github.com/splinesoft/SSDynamicText/issues/36). _([Grubas7](https://github.com/Grubas7))_
- **(added)** Added Carthage support (by creating SSDynamicText project with framework target). _([Grubas7](https://github.com/Grubas7))_

## 1.0.0
###### June 5, 2016

- **(fixed)** Fixed `titleLabel` font upgrade for `SSDynamicButton` after font change, [#27](https://github.com/splinesoft/SSDynamicText/issues/27). _([Grubas7](https://github.com/Grubas7))_
- **(modified)** Changed `ss_defaultFontName`, and `ss_defaultBaseSize` from methods to readonly properties. _([Grubas7](https://github.com/Grubas7))_

## 0.5.0
###### October 5, 2015

- **(added)** Added `NSAttributedString` support. _([Remiki](https://github.com/Remki))_

## 0.4.0
###### July 19, 2015

- **(added)** Added `SSDynamicButton` class, [#8](https://github.com/splinesoft/SSDynamicText/issues/8). _([Grubas7](https://github.com/Grubas7))_
- **(modified)** Made views class methods inheritable, issue [#7](https://github.com/splinesoft/SSDynamicText/issues/7). _([jhersh](https://github.com/jhersh))_

## 0.3.0
###### July 15, 2015

- **(modified)** Removed double initialization for views, [#6](https://github.com/splinesoft/SSDynamicText/issues/6). _([jhersh](https://github.com/jhersh))_

## 0.2.2
###### April 24, 2015

- **(added)** Added support for accessibility content size categories. _([Remiki](https://github.com/Remki))_
- **(modifed)** Fixed font and font size settings for views loaded from Interface Builder. _([Remiki](https://github.com/Remki))_

## 0.2.1
###### October 30, 2014

- **(added)** Added `-ss_defaultFontName` and `-ss_defaultBaseSize` methods to `UIView+SSTextSize` class. _([angrauel](https://github.com/angrauel))_

## 0.2.0
###### October 23, 2014

- **(added)** Added Interface Builder support. _([angrauel](https://github.com/angrauel))_

## 0.1.0
###### October 7, 2013

- **(added)** Added `SSDynamicTextView`,  `SSDynamicTextField` and `UIView+SSTextSize` classes. _([jhersh](https://github.com/jhersh))_
- **(modified)** Renamed `SSLabel` to `SSDynamicLabel`. _([jhersh](https://github.com/jhersh))_

## 0.0.1
###### October 7, 2013

- **(added)** Added `SSDynamicLabel`, `UIFont+SSTextSize` and `UIApplication+SSTextSize` classes. _([jhersh](https://github.com/jhersh))_
