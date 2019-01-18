---
layout: page
title: Favorites
description: my favorite, my favorite
keywords: Favorites
comments: true
menu: Favorites
permalink: /favorites/
---

> Games

{% for game in site.data.favorites.games %}
* [{{ game.name }}]({{ game.url }})
{% endfor %}

> Quotations

{% for quotation in site.data.favorites.quotations %}
* [{{ quotation.name }}]({{ quotation.url }})
{% endfor %}

> Softwares

{% for software in site.data.favorites.softwares %}
* [{{ software.name }}]({{ software.url }})
{% endfor %}
