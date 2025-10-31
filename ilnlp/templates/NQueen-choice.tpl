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

#modeha(1, queen(var(row),var(col))).
#modeb( queen(var(row), var(col))).
#modeb( var(row) != var(row), (positive)).
#modeb( var(col) != var(col), (positive)).
#modeb( var(row) - var(row) = var(col) - var(col), (positive)).
#modeb( row(var(row)), (positive)).
#modeb( column(var(col)),(positive)).
#maxv(4).
#maxhl(1).
