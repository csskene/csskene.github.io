---
layout: page
title: Tutorials
permalink: /tutorials/
---

My tutorials are collected here.  

<ul>
  {% for post in site.posts %}
    {% if post.categories[0] == 'tutorial' %}
      <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>