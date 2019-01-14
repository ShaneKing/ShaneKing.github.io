---
layout: page
title: Favorites
description: my favorite, my favorite
keywords: Favorites
comments: true
menu: Favorites
permalink: /favorites/
---

> Quotations

{% for quotation in site.data.favorites.quotations %}
* [{{ quotation.name }}]({{ quotation.url }})
{% endfor %}

> Sites

{% for sit in site.data.favorites.sites %}
* [{{ sit.name }}]({{ sit.url }})
{% endfor %}

> Softwares

{% for software in site.data.favorites.softwares %}
* [{{ software.name }}]({{ software.url }})
{% endfor %}
