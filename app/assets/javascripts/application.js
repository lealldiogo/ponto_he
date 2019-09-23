//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require serviceworker-companion
//= require bootstrap-datepicker

// Função retirada da thread https://pt.stackoverflow.com/questions/237762/remover-acentos-javascript
// Utilizada no app para retirar acentos dos filtros de busca. Ver views/shared/_filtro_digitacao.html.erb
function retira_acentos(str) {
  // string de referência com todos os possíveis caracteres especiais
  const com_acento = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝŔÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿŕ";
  // string com os caracteres que substituirão os especiais, com mesmo tamanho e na mesma ordem que com_acento
  const sem_acento = "AAAAAAACEEEEIIIIDNOOOOOOUUUUYRsBaaaaaaaceeeeiiiionoooooouuuuybyr";
  // novastr será a string a ser retornada limpa de acentos
  var novastr="";
  // para cada caracter da string que terá seus acentos retirados str
  for(i=0; i<str.length; i++) {
      var troca=false;
      for (a=0; a<com_acento.length; a++) {
          if (str.substr(i,1)==com_acento.substr(a,1)) {
              // se o caracter de str for especial, este é substituído pelo caracter de sem_acento na mesma posição
              novastr+=sem_acento.substr(a,1);
              troca=true;
              break;
          }
      }
      if (troca==false) {
          // caso o caracter de str não seja especial, mantém-se o mesmo caracter sem substituir
          novastr+=str.substr(i,1);
      }
  }
  return novastr;
}
