export const dustData = [{
    currentLocation:'수지',
    dustValue:'15',
    status :'좋음',
    time:'16:00'
},
{
    currentLocation:'강남',
    dustValue:'22',
    status :'보통',
    time:'10:00'
},
{
    currentLocation:'이태원',
    dustValue:'55',
    status :'나쁨',
    time:'20:00'
},
{
    currentLocation:'연남동',
    dustValue:'100',
    status :'매우 나쁨',
    time:'06:00'
}]

export const dustCriteria ={
    good :[0,15],
    normal:[16,35],
    bad:[36,75],
    worst:[76,null]
}