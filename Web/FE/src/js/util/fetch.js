export const getFetch =(url,data)=>{
  return fetch(url,{
    headers : {
      'Content-Type' :'application/json'
    },
    mode:'cors',
    body :JSON.stringify(data)
  })
}