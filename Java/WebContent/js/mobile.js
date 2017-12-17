function showMenu(){
  var menu = document.getElementsByClassName('menu-mobile')[0];
  var botoes = document.getElementsByClassName('botoes-mobile')[0];
  if(menu.style.width === '0px' ||  menu.style.width === '' ){
    menu.style.width = '550px';
    botoes.style.display = "block";
  }else{
    menu.style.width = '0px';
    botoes.style.display = "none";
  }
}
