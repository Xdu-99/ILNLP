{#- see https://keats.github.io/tera/docs/ -#}

{% for r in background %}
{{r}}
{%- endfor -%}

{% for e in pos_examples %}
#pos{%- raw -%}({ {%- endraw -%} {{ e.incl | join(sep=",")  }} {% raw %} },{{% endraw %} {{ e.excl | join(sep=",")  }} {% raw %} },{{% endraw %} {{ e.ctx | concat(with='') | join(sep=". ")  }} {% raw %}}{% endraw %}).

{%- endfor -%}

{% for e in neg_examples %}
#neg{%- raw -%}({ {%- endraw -%} {{ e.incl | join(sep=",")  }} {% raw %} },{{% endraw %} {{ e.excl | join(sep=",")  }} {% raw %} },{{% endraw %} {{ e.ctx | concat(with='') | join(sep=". ")  }} {% raw %}}{% endraw %}).

{%- endfor -%}


#modeh(c(var(node),var(color))).
#modeh(noc(var(node),var(color))).
#modeb(noc(var(node),var(color))).
#modeb(e(var(node), var(node)), (positive)).
#modeb(color(var(color)), (positive)).
#modeb(v(var(node)), (positive)).
#modeb(c(var(node),var(color))).
#modeb(var(color) != var(color), (positive)).
