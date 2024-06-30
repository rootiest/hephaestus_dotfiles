# Defined in - @ line 1
function ls --wraps='lsd --hyperlink=auto' --description 'alias ls=lsd --hyperlink=auto'
  lsd --hyperlink=auto $argv;
end
