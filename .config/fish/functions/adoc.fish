function adoc --wraps='asciidoctor -d book' --description 'alias adoc asciidoctor -d book'
  asciidoctor -d book $argv; 
end
