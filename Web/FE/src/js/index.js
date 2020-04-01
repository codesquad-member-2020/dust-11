import {dustData,dustCriteria,dustStatus,dustImoji} from './data/mockdata.js'
import {getEl,getAll} from './util/selector.js';


const currentDate =`${new Date().getFullYear()}-${
    new Date().getMonth()+1 < 10 ? `0${new Date().getMonth()+1}`:new Date().getMonth()+1}-${
    new Date().getDate()<10 ? `0${new Date().getDate()}`: new Date().getDate()}`

const getMyLocation =()=>{
    //동이름을 리턴해줘야 한다
    const options ={
        timeout:Infinity,
        enableHighAccuracy:true,
        maximumAge:0
    }
    const handleSuccess =(data)=>{
       const latitude=data.coords.latitude;
       const longitude=data.coords.longitude;
       return {latitude,longitude};
    }
    const handleError=(error)=>{
        console.log(error.code,error.message);
    }
    navigator.geolocation.getCurrentPosition(handleSuccess,handleError,options);
    //동네 이름 반환
    return 
}

const timeUrl ='https://dust11.herokuapp.com/api/_hcheck';
const imageUrl ='https://dust11.herokuapp.com/api/pm10';
const myUrl ='https://dust11.herokuapp.com/api/dust';
const dateUrl=`https://dust11.herokuapp.com/api/pm10/${currentDate}`
const locationUrl =`https://dust11.herokuapp.com/api/dust/${getMyLocation()}`


const getData = (url)=>{
     fetch(url)
        .then((response)=>response.json())
        .then((data)=>console.log(data.list));
}

// '2020-04-01'
getData(dateUrl)

const decideStatus = (dustData,dustCriteria)=>{
    //fetch로 데이터 최근 24시간 데이터 받아와야
    //스크롤 움직일때마다 실행 + 제일 처음 것만 돔에 넣어서 바꿔주기
        const dustValue=dustData.map((data)=>parseInt(data.dustValue));
        let statusArr =[];
        dustValue.forEach((dustQuantity)=>{
            dustQuantity=parseInt(dustQuantity);
            dustCriteria.map((criteria,index)=>{
                let [minValue,maxValue]=criteria;
                    minValue = parseInt(minValue),  
                    maxValue = parseInt(maxValue),
                    index=(dustQuantity>=minValue &&dustQuantity<=maxValue) ? index : false;
                if (index===false) return;
                statusArr.push(dustStatus[index]);
                const emojiContainer=getEl('.header-contents .dust-emoji');
                emojiContainer.innerText=dustImoji[index];// index의 마지막에는 lastIndex가 담김
                const statusContiner=getEl('.header-contents h4');
                statusContiner.innerText=statusArr[index]                
            })
        }) 
}
//미세먼지 농도 / 시간 / 위치  + 스크롤시 가장 위에 것에 대해 상태 판단하게;
const init=()=>{
    decideStatus(dustData,dustCriteria)
}


init();



