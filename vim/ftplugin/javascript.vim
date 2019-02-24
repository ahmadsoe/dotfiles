" for json
command! -buffer Reformat %!jq .
command! -buffer Unminify %!js-beautify -f --indent-size=2 -
