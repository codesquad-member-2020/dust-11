import { getElement } from './commonUtil.js';
const CORS_API = 'https://cors-anywhere.herokuapp.com/';
const KAKAO_API_KEY = 'KakaoAK 카카오 REST API KEY 발급 받으셔야 해요!';
const KAKAO_TRANS_COORDINATE_API = 'https://dapi.kakao.com/v2/local/geo/transcoord.json';
const GET_MEASURING_STATION_API = 'http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList';
const GET_DUST_API = 'http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty';
const SERVICE_KEY = '&_returnType=json&ServiceKey=공공 API SERVICE KEY 발급 받으셔야 해요!';
const stationEl = getElement('#station');
const currDustEl = getElement('#currDust');
const dataTimeEl = getElement('#dataTime');
const gradeTextEl = getElement('#grade-text');
const gradeIconEl = getElement('#grade-icon');
let station = null;
let currDustInfo = null;
let currDust = null;
let currGrade = null;
let dataTime = null;
navigator.geolocation.getCurrentPosition(success, fail, {
    enableHighAccuracy: true,
    maximumAge: 0,
    timeout: Infinity
});
async function success(position) {
    const date = new Date();
    const dustDateKey = `${date.getFullYear()}${date.getMonth() + 1}${date.getDate()}${date.getHours()}`;
    const dustData = JSON.parse(localStorage.getItem(`DUST_DATA_${dustDateKey}`));
    if (dustData) {
        currDustInfo = dustData[0];
        dataTime = currDustInfo.dataTime.slice(-5);
        currDust = currDustInfo.pm10Value;
        currGrade = currDustInfo.pm10Grade;
        station = localStorage.getItem('DUST_STATION');
        template(dustDateKey);
        return;
    }
    const firstURL = await fetch(`${KAKAO_TRANS_COORDINATE_API}?x=${position.coords.longitude}&y=${position.coords.latitude}&input_coord=WGS84&output_coord=TM`, { headers: { Authorization: KAKAO_API_KEY } })
        .then(res => res.json())
        .then(json => {
            const [transCoord] = json.documents;
            return `${GET_MEASURING_STATION_API}?tmX=${transCoord.x}&tmY=${transCoord.y}${SERVICE_KEY}`;
        });
    const secondURL = await fetch(CORS_API + firstURL)
        .then(res => res.json())
        .then(json => {
            const [location] = json.list;
            localStorage.setItem(`DUST_STATION`, location.stationName);
            return `${GET_DUST_API}?stationName=${location.stationName}&dataTerm=month&pageNo=1&numOfRows=25${SERVICE_KEY}`
        });
    fetch(CORS_API + secondURL)
        .then(res => res.json())
        .then(json => {
            console.log(json.list);
            currDustInfo = json.list[0];
            dataTime = currDustInfo.dataTime.slice(-5);
            currDust = currDustInfo.pm10Value;
            currGrade = currDustInfo.pm10Grade;
            console.log(json.list);
            station = localStorage.getItem('DUST_STATION');
            localStorage.setItem(`DUST_DATA_${dustDateKey}`, JSON.stringify(json.list))
            template(dustDateKey);
        });
}
function fail(error) {
    console.log(error);
}
function template(dustDateKey) {
    stationEl.innerHTML = station;
    currDustEl.innerHTML = currDust;
    dataTimeEl.innerHTML = dataTime;
    switch (currGrade) {
        case '1': gradeTextEl.innerHTML = '좋음'; gradeIconEl.innerHTML = '😄';
            break;
        case '2': gradeTextEl.innerHTML = '보통'; gradeIconEl.innerHTML = '🙂';
            break;
        case '3': gradeTextEl.innerHTML = '나쁨'; gradeIconEl.innerHTML = '😷';
            break;
        case '4': gradeTextEl.innerHTML = '매우 나쁨'; gradeIconEl.innerHTML = '👿';
            break;
    }
    const prevDustData = JSON.parse(localStorage.getItem(`DUST_DATA_${dustDateKey}`)).slice(1);
    const dustTimelineGraph = getElement('.dust-timeline-graph');
    dustTimelineGraph.innerHTML = prevDustData.reduce((acc, cur) => {
        const graphWidth = cur.pm10Value / 2 <= 100 ? cur.pm10Value / 2 : 100;
        let graphColor;
        switch (cur.pm10Grade) {
            case '1': graphColor = 'blue';
                break;
            case '2': graphColor = 'green';
                break;
            case '3': graphColor = 'orange';
                break;
            case '4': graphColor = 'red';
                break;
        }
        acc += `<li>
                    <span class="dust-graph" style="width: ${graphWidth}%; background-color : ${graphColor}"></span>
                    <span class="dust-value">${cur.pm10Value}</span>
                </li>`
        return acc;
    }, '');
}