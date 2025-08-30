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

#modeh(1, in(var(node),var(node))).
#modeh(1, nin(var(node),var(node))).
#modeb( nin(var(node),var(node))).
#modeb( edge(var(node), var(node)), (positive)).
#modeb( var(node) != var(node), (positive)).
#modeh( reach(var(node))).
#modeb( reach(var(node))).
#modeb( node(var(node)), (positive)).
#modeb( in(var(node),var(node))).
#modeb( initial(var(node)), (positive)).
