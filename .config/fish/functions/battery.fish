# Defined in - @ line 1
function battery --wraps=acpi --description 'alias battery acpi'
  acpi  $argv;
end
