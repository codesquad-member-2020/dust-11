import {dustData,dustCriteria} from './data/mockdata.js'


//data has 24hours data
const decideStatus = (dustData,dustCriteria)=>{
    //fetch로 데이터 최근 24시간 데이터 받아와야
        const dustValue=dustData.filter((data)=>data.dustValue);
        console.log(dustValue)
}

const init=()=>{
    decideStatus(dustData,dustCriteria)
}

init();