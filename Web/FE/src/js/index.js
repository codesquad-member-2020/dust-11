import {dustData,dustCriteria,dustStatus,dustImoji} from './data/mockdata.js'
import {getEl,getAll} from './util/selector.js';
import {getFetch} from './util/fetch.js';

const currentDate =`${new Date().getFullYear()}-${
    new Date().getMonth()+1 < 10 ? `0${new Date().getMonth()+1}`:new Date().getMonth()+1}-${
    new Date().getDate()<10 ? `0${new Date().getDate()}`: new Date().getDate()}`

const timeUrl ='https://dust11.herokuapp.com/api/_hcheck';
const imageUrl ='https://dust11.herokuapp.com/api/pm10';
const myUrl ='https://dust11.herokuapp.com/api/dust';
const dateUrl=`https://dust11.herokuapp.com/api/pm10/${currentDate}`





const chooseGrade=(grade)=>{
    const dustInfo = {
        emoji: null,
        grade: null,
        backgroundColor: null
      };
    switch (grade) {
        case '1':
            dustInfo.emoji='😀';
            dustInfo.grade='좋음';
            dustInfo.backgroundColor='#6096D8';
            break;
          case '2':
            dustInfo.emoji='🙂';
            dustInfo.grade='보통';
            dustInfo.backgroundColor='#088A68';
            break;
          case '3':
            dustInfo.emoji='😷';
            dustInfo.grade='나쁨';
            dustInfo.backgroundColor='#FAAC58';
            break;
          case '4':
            dustInfo.emoji='😱';
            dustInfo.grade='매우 나쁨';
            dustInfo.backgroundColor='#FA5858';
            break;
    }
    return dustInfo
}

const calGraphWidth = (dustValue)=>{
    const maxValue=200;
    const maxPercent=100;
    const percent = parseInt((dustCriteria/maxValue)*100);
    if (percent>=maxPercent) return 100;
    else return percent;
}

const render= (grade,value,stationName,time)=>{
    const emojiEl=getEl('.dust-emoji');
    const gradeEl=getEl('.header-contents h4');
    const quantitiyEl=getEl('.dust-header-quantity');
    const timeEl = getEl('.dust-time');
    const stationEl=getEl('.dust-location');
    const headerContainer = getEl('#header');
    const info =chooseGrade(grade);
    // console.log(info)

    headerContainer.style.backgroundColor=info.backgroundColor;
    emojiEl.innerHTML=info.emoji;
    gradeEl.innerHTML=grade;
    quantitiyEl.innerHTML=`${value}&micro;g/㎥;`;
    timeEl.innerHTML=`${time}`;
    stationEl.innerHTML=stationName;

}


// '2020-04-01'
const init=()=>{
    const options ={
        timeout:Infinity,
        enableHighAccuracy:true,
        maximumAge:0
    }
    const handleSuccess =(data)=>{
        const latitude = data.coords.latitude;
        const longitude= data.coords.longitude;
        const locationUrl=`http://52.7.82.194:8080/api/location/${longitude}/${latitude}`
        getFetch(locationUrl)
            .then((response)=>response.json())
            .then((data)=>{
                console.log(data,data.list[0].dataTime.slice(11)); //매 정시의 값을 현재 시각보다 24시간 기준으로 보여준다
                const stationName= data.stationName;
                const {pm10Grade:grade,pm10Value:value,dataTime}=data.list[0];
                const time = dataTime.slice(11);
                render(grade,value,stationName,time);
            })
    }
    const handleError=(error)=>{
        console.log(error.code,error.message);
    }
    navigator.geolocation.getCurrentPosition(handleSuccess,handleError,options);
}

init();



