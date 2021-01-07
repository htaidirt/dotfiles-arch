# Defined in - @ line 1
function search --wraps='find . -name' --description 'alias search find . -name'
  find . -name $argv;
end
