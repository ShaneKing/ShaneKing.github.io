---
layout: page
title: Favorites
description: my favorite, my favorite
keywords: Favorites
comments: true
menu: Favorites
permalink: /favorites/
---

> My favorite site & software.

{% for link in site.data.links %}
* [{{ link.name }}]({{ link.url }})
{% endfor %}
