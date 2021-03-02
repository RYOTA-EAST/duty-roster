window.addEventListener('load', function(){
  // 表要素取得
  const days = document.getElementsByTagName ("tr")
  const users = document.getElementsByTagName ("td")

  // user_id取得
  for( var i=0,l=users.length; l>i; i++ ) {
    var user = users[i] ;
    user.addEventListener('click', function(){

      for( var i=0,l=users.length; l>i; i++ ) {
        if (users[i].style.background = 'red') {
          users[i].style.background = 'none'
        }
      }
      if (this.id == ""){
        document.getElementById('roster_user_id').value = this.className
        this.style.backgroundColor = 'red'
          // 日付取得
        for( var i=0,l=days.length; l>i; i++ ) {
          
          var day = days[i] ;
          day.addEventListener('click', function(){
          document.getElementById('roster_date').value = this.id
          })
        }
      }else{
        document.getElementById('roster_user_id').value = null
        document.getElementById('roster_date').value = null
      }
    })
  }
})