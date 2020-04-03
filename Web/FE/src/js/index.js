import {emojiEl,gradeEl,quantitiyEl,timeEl,stationEl,headerContainer,dustGraphContainer} from './util/elements.js';
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
        backgroundColor: null,
        graphColor : null
      };
    switch (grade) {
        case '1':
            dustInfo.emoji='😀';
            dustInfo.grade='좋음';
            dustInfo.backgroundColor='#6096D8';
            dustInfo.graphColor ='#0080FF';
            break;
          case '2':
            dustInfo.emoji='🙂';
            dustInfo.grade='보통';
            dustInfo.backgroundColor='#088A68';
            dustInfo.graphColor ='#04B404';
            break;
          case '3':
            dustInfo.emoji='😷';
            dustInfo.grade='나쁨';
            dustInfo.backgroundColor='#FAAC58';
            dustInfo.graphColor ='#FE9A2E';
            break;
          case '4':
            dustInfo.emoji='😱';
            dustInfo.grade='매우 나쁨';
            dustInfo.backgroundColor='#FA5858';
            dustInfo.graphColor ='#DF0101';
            break;
    }
    return dustInfo
}

const calGraphWidth = (dustValue)=>{
    const maxValue=200;
    const maxPercent=100;
    const percent = parseInt((dustValue/maxValue)*100);
    if (percent>=maxPercent) return 100;
    else return percent;
}

const renderGraph=(dustObj)=>{
    const {dustPercentArr,dustValueArr,graphColorArr}=dustObj;
    console.log(dustObj)
    const graphHTML=dustPercentArr.map((value,index)=>`
    <li class="dust-graph">
        <span class="dust-contents-bar" style="background-color:${graphColorArr[index]}; width:${value}%;"></span>   
        <span class="dust-contents-quantity">${dustValueArr[index]}</span>
    </li>`).join('');
    return graphHTML;
}

const renderAll= (info)=>{
    const {
        grade,
        value,
        stationName,
        time,
        dustPercentArr,
        dustValueArr,
        graphColorArr
    }=info
    const gradeInfo =chooseGrade(grade); 
    console.log(gradeInfo,graphColorArr,info)

    headerContainer.style.background='linear-gradient(gradeInfo.backgroundColor,#fff)';
    headerContainer.style.backgroundColor=gradeInfo.backgroundColor;
    emojiEl.innerHTML=gradeInfo.emoji;
    gradeEl.innerHTML=gradeInfo.grade;
    quantitiyEl.innerHTML=`${value}&micro;g/㎥`;
    timeEl.innerHTML=`${time}`;
    stationEl.innerHTML=stationName;
    dustGraphContainer.innerHTML = renderGraph({dustPercentArr,dustValueArr,graphColorArr})
}

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
        const dustValueArr=[];
        const graphColorArr=[];
        getFetch(locationUrl)
            .then((response)=>response.json())
            .then((data)=>{
                console.log(data)
                const dustPercentArr=data.list.map((data)=>{
                    graphColorArr.push(chooseGrade(data.pm10Grade1h).graphColor)
                    dustValueArr.push(parseInt(data.pm10Value));
                    return calGraphWidth(parseInt(data.pm10Value))
                });
                const stationName= data.stationName;
                const {pm10Grade1h:grade,pm10Value:value,dataTime}=data.list[0];
                const time = dataTime.slice(11);
                const dustInfo = {
                    grade,value,stationName,time,dustPercentArr,dustValueArr,graphColorArr
                }
                renderAll(dustInfo);
            })
    }
    const handleError=(error)=>{
        console.log(error.code,error.message);
    }
    navigator.geolocation.getCurrentPosition(handleSuccess,handleError,options);
}

window.addEventListener('DOMContentLoaded',init);



