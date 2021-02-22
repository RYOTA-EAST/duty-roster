window.addEventListener('load', function(){
  const tables = document.getElementsByTagName ("tr")
  console.log(tables)
    for( var i=0,l=tables.length; l>i; i++ ) {
      var table = tables[i] ;
      table.addEventListener('click', function(){
      console.log(this.id)
    })
    }
  const tables2 = document.getElementsByTagName ("td")
  console.log(tables2)
    for( var i=0,l=tables2.length; l>i; i++ ) {
      var table = tables2[i] ;
      table.addEventListener('click', function(){
      console.log(this.className)
    })
    }
  
})