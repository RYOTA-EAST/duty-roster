window.addEventListener('load', function(){
  // 表要素取得
  const days = document.getElementsByTagName ("tr")
  const users = document.getElementsByTagName ("td")
  // 日付取得
  for( var i=0,l=days.length; l>i; i++ ) {
    var day = days[i] ;
    day.addEventListener('click', function(){
      document.getElementById('roster_date').value = this.id
    })
  }
  // user_id取得
  for( var i=0,l=users.length; l>i; i++ ) {
    var user = users[i] ;
    user.addEventListener('click', function(){
      for( var i=0,l=users.length; l>i; i++ ) {
        users[i].style.background = 'white'
      }
      document.getElementById('roster_user_id').value = this.className
      this.style.backgroundColor = 'red'
    })
  }
})