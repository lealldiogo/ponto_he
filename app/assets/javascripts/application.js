//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require serviceworker-companion
//= require bootstrap-datepicker

function retira_acentos(str) {
  const com_acento = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝŔÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿŕ";
  const sem_acento = "AAAAAAACEEEEIIIIDNOOOOOOUUUUYRsBaaaaaaaceeeeiiiionoooooouuuuybyr";
  var novastr="";
  for(i=0; i<str.length; i++) {
      var troca=false;
      for (a=0; a<com_acento.length; a++) {
          if (str.substr(i,1)==com_acento.substr(a,1)) {
              novastr+=sem_acento.substr(a,1);
              troca=true;
              break;
          }
      }
      if (troca==false) {
          novastr+=str.substr(i,1);
      }
  }
  return novastr;
}
