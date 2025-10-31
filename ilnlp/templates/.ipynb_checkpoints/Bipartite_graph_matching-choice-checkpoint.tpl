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

#modeh(1, match(var(node1),var(node2))).
#modeh(1, not_match(var(node1),var(node2))).
#modeb( not_match(var(node1),var(node2))).
#modeb( match(var(node1),var(node2))).
#modeb( var(node1) != var(node1), (positive)).
#modeb( var(node2) != var(node2), (positive)).
#modeb( edge(var(node1),var(node2)), (positive)).


