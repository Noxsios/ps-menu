# PS-Menu
Simple module to generate interactive console menus (like yeoman)

# Example:

```powershell
menu @("option 1", "option 2", "option 3")
```

# Features

* Returns value of selected menu item
* Returns index of selected menu item (using `-ReturnIndex` switch)
* Navigation with `up/down` arrows
* Navigation with `j/k` (vim style)
* Esc key quits the menu (`null` value returned)

# Forked From

> https://github.com/chrisseroka/ps-menu

