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

#modeh(1, cell(var(row),var(col),var(num))).
#modeh(1, no_cell(var(row),var(col),var(num))).
#modeb( cell(var(row),var(col),var(num))).
#modeb( no_cell(var(row),var(col),var(num))).
#modeb( row(var(row)),(positive)).
#modeb( col(var(col)),(positive)).
#modeb( num(var(num)),(positive)).
#modeb( block(var(bloc), var(row), var(col)), (positive)).
#modeb( var(row) != var(row), (positive)).
#modeb( var(col) != var(col), (positive)).
#modeh( has_number(var(row), var(col))).
#modeb( has_number(var(row), var(col))).

