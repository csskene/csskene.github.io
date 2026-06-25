---
layout: page
title: Publications
permalink: /publications/
---

My research outputs are collected here along with links to the article, accepted version, and any relevant code.

{% assign preprints = site.data.publications.publications | where: "status", "Preprint" %}
{% assign published = site.data.publications.publications | where: "status", "Published" %}

{% if preprints.size > 0 %}
## Preprints

{% for pub in preprints %}
{%- assign authors = pub.authors | join: ", " -%}
{%- assign authors = authors | replace: "Skene, C.S.", "<strong>Skene, C.S.</strong>" -%}
* {{ authors }}, '{{ pub.title }}', {{ pub.year }},
  {% for link in pub.links -%}
    {%- assign icon = "" -%}
    {%- if link.type == "Code" -%}
      {%- assign icon = "/assets/publications/github-mark-white.png" -%}
    {%- elsif link.type == "Preprint" -%}
      {%- assign icon = "https://static.arxiv.org/static/browse/0.3.4/images/icons/smileybones-pixel.png" -%}
    {%- elsif link.type == "DOI" -%}
      {%- assign icon = "https://production2.leeds.ac.uk/jaducdn//images/doi.png" -%}
    {%- elsif link.type == "Accepted Version" -%}
      {%- assign icon = "https://eprints.whiterose.ac.uk/images/WRRO_logo_green.png" -%}
    {%- endif -%}
    [{{ link.type }} <img src="{{ icon }}" style="width:1em;">]({{ link.url }}){%- unless forloop.last %}, {% endunless -%}
  {%- endfor -%}
  {%- if pub.bibtex %}
  <details><summary markdown="span">BibTeX reference</summary>
  <pre><code class="language-bibtex" id="bibtex-pre-{{ forloop.index }}">{{ pub.bibtex | strip }}</code></pre>
  </details>
  {%- endif %}
{% endfor %}
{% endif %}

## Publications

{% for pub in published %}
{%- assign authors = pub.authors | join: ", " -%}
{%- assign authors = authors | replace: "Skene, C.S.", "<strong>Skene, C.S.</strong>" -%}
* {{ authors }}, '{{ pub.title }}', {{ pub.journal }}, {{ pub.year }},
  {% for link in pub.links -%}
    {%- assign icon = "" -%}
    {%- if link.type == "Code" -%}
      {%- assign icon = "/assets/publications/github-mark-white.png" -%}
    {%- elsif link.type == "Preprint" -%}
      {%- assign icon = "https://static.arxiv.org/static/browse/0.3.4/images/icons/smileybones-pixel.png" -%}
    {%- elsif link.type == "DOI" -%}
      {%- assign icon = "https://production2.leeds.ac.uk/jaducdn//images/doi.png" -%}
    {%- elsif link.type == "Accepted Version" -%}
      {%- assign icon = "https://eprints.whiterose.ac.uk/images/WRRO_logo_green.png" -%}
    {%- endif -%}
    [{{ link.type }} <img src="{{ icon }}" style="width:1em;">]({{ link.url }}){%- unless forloop.last %}, {% endunless -%}
  {%- endfor -%}
  {%- if pub.bibtex %}
  <details><summary markdown="span">BibTeX reference</summary>
  <pre><code class="language-bibtex" id="bibtex-pub-{{ forloop.index }}">{{ pub.bibtex | strip }}</code></pre>
  </details>
  {%- endif %}
{% endfor %}