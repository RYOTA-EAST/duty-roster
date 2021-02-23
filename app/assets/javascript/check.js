window.addEventListener('load', function(){
  const rows = document.getElementsByTagName ("tr")
  const checks = document.getElementsByTagName ("td")
  const duty = location.pathname.replace(/[^-^0-9^\.]/g,"")
  console.log(location)
  console.log(duty)
  console.log(rows)
    for( var i=0,l=rows.length; l>i; i++ ) {
      var row = rows[i] ;
      row.addEventListener('dblclick', function(){
      console.log(this.id)
      localStorage.getItem('date', this.id)
    })
  }
  console.log(checks)
    for( var i=0,l=checks.length; l>i; i++ ) {
      var check = checks[i] ;
      check.addEventListener('dblclick', function(){
      console.log(this.className)
      localStorage.setItem('user', this.className)
      // window.location.href = '/duties/' + duty + '/rosters/new'
    })
  }
})