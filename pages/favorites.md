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

{% for favorite in site.data.favorites %}
* [{{ favorite.name }}]({{ favorite.url }})
{% endfor %}
